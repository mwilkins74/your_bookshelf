class Book < ApplicationRecord

  # belongs_to :user

  def formatted_started_date
    started_date.strftime("%m/%d/%Y") if started_date
  end

  def formatted_finished_date
    finished_date.strftime("%m/%d/%Y") if finished_date
  end

  def calculate_duration
    duration = finished_date - started_date
    duration.to_i
  end

end

