class Task < ActiveRecord::Base
  belongs_to :project

  scope :between, ->(range) {
    from , to = range.split(' - ')
    where("? <= start_at and start_at <= ?", Time.parse(from), Time.parse(to)).order(:start_at)
  }
  
  def time_second
    end_at - start_at
  end

  def time_hour
    (time_second / 3600).round(1)
  end

  def self.prepare_params(params)
    params[:start_at] = Time.parse(params[:date] + " " + params[:starttime])
    params[:end_at]   = Time.parse(params[:date] + " " + params[:endtime])

    params.delete :date
    params.delete :starttime
    params.delete :endtime

    params
  end

  def self.to_csv
    header = ['date','start','end','task_name', 'code', 'time']
    CSV.generate(row_sep: "\r\n") do |csv|
      csv << header
      all.each do |task|
       csv << [task.start_at.to_s(:date), task.start_at.to_s(:time), task.end_at.to_s(:time), task.name, task.project.code, task.time_second / 60 ]
      end
    end
  end

  def self.import(file)
    CSV.open(file.path, "r", :headers => :first_row).each do |d|
      project = Project.where(code: d[4].strip)[0]
      start_at = Time.parse(d[0] + " " + d[1])
      end_at =  Time.parse(d[0] + " " + d[2])
      t = Task.create(name: d[3], start_at: start_at, end_at: end_at, project: project)
    end
  end
end
