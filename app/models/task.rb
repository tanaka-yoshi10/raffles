class Task < ActiveRecord::Base
  belongs_to :project

  def time_second
    end_at - start_at
  end

  def self.by_start_date(date)
    where("start_at LIKE ?", "#{date}%").order(:start_at)
  end
end
