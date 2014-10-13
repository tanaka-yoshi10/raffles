class Task < ActiveRecord::Base
  belongs_to :project

  def time_second
    end_at - start_at
  end

  def self.by_start_date(date)
    where("? <= start_at and start_at <= ?", date.beginning_of_day, date.end_of_day).order(:start_at)
  end

  def self.by_month(date)
    where("? <= start_at and start_at <= ?", date.beginning_of_month, date.end_of_month).order(:start_at)
  end
end
