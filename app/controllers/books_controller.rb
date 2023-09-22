class BooksController < ApplicationController

  def index
    @books = current_user.books.order("created_at ASC").page(params[:page]).per(10)
    total_books_read
    number_of_pages_read
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
end
