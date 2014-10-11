class Task < ActiveRecord::Base
  belongs_to :project

  def time_second
    end_at - start_at
  end
end
