class BooksController < ApplicationController

  def index
    @years_collection = current_user.books.pluck(:finished_date).map { |date| date&.year }.compact.uniq.sort.reverse
    @selected_year = params[:year].to_i if params[:year].present?
    
    @books = current_user.books.order("created_at ASC")
    
    if @selected_year.present?
      @books = @books.where("strftime('%Y', finished_date) = ?", @selected_year.to_s)
    end
    
    @books = @books.page(params[:page]).per(10)
    
    calculate_totals
  end

  def show
    @book = find_book
  end

  def new
    @book = Book.new
  end

  def edit
    @book = find_book
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to books_path
      flash[:success] = "Book was successfully created."
    else
      flash[:error] = @book.errors.full_messages
      render :new
    end
  end

  def update
    @book = find_book

    if @book.update(book_params)
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = current_user.books.find_by(id: params[:id])

    if @book
      @book.destroy
      redirect_to books_path, notice: 'Book was successfully deleted.'
    else
      redirect_to books_path, alert: 'Book not found.'
    end
  end

  private
  def book_params
    params.require(:book).permit(
      :title,
      :author,
      :description,
      :number_of_pages,
      :started_date,
      :finished_date
    ).merge(user_id: current_user.id)
  end

  def find_book
    Book.find(params[:id])
  end

  def total_books_read
    @total_books_read = Book.count if @books.present?
  end

  def number_of_pages_read
    @number_of_pages_read = Book.sum(:number_of_pages) if @books.present?
  end

  def calculate_totals
    if @books.present?
      @total_books_read = @books.total_count
      @number_of_pages_read = current_user.books.where("strftime('%Y', finished_date) = ?", @selected_year.to_s).sum(:number_of_pages)
    else
      @total_books_read = 0
      @number_of_pages_read = 0
    end
  end
end
