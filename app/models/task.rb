require 'bigdecimal'
require 'bigdecimal/util'

class Task < ActiveRecord::Base
  belongs_to :project
  validates :name, presence: true
  validates :date, presence: true
  validates :starttime, presence: true
  validates :endtime, presence: true
  attr_writer :date, :starttime, :endtime

  before_validation :set_date

  scope :between, ->(range) {
    from , to = range.split(' - ')
    where("? <= start_at and start_at <= ?", Time.parse(from), Time.parse(to)).order(:start_at)
  }

  def date
    @date || self.start_at.strftime('%Y-%m-%d') if self.start_at.present?
  end

  def starttime
    @starttime || self.start_at.strftime('%H:%M') if self.start_at.present?
  end

  def endtime
    @endtime || self.end_at.strftime('%H:%M') if self.end_at.present?
  end

  def set_date
    if @date && @starttime && @endtime
      self.start_at = Time.parse(@date + " " + @starttime)
      self.end_at   = Time.parse(@date + " " + @endtime)
    end
  end
  
  def time_second
    end_at - start_at
  end

  def time_hour
    (time_second / 3600.0).to_d.floor(1)
  end

  def self.to_csv
    header = ['date','start','end','task_name', 'code', 'time']
    CSV.generate(row_sep: "\r\n") do |csv|
      csv << header
      all.each do |task|
        csv << [task.start_at.to_s(:date), task.start_at.to_s(:time), task.end_at.to_s(:time), task.name, task.project.code, task.time_hour ]
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
