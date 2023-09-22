class AddStartedAndFinishedDateToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :started_date, :date
    add_column :books, :finished_date, :date
  end
end
