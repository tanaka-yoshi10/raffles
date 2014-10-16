require 'time'
require 'csv'
require "#{Rails.root}/app/models/project"

CSV.open("hoge.csv", "r").each do |d|
  project = Project.where(code: d[3].strip)[0]
  start_at = Time.parse(d[0] + " " + d[1])
  end_at =  Time.parse(d[0] + " " + d[2])
  t = Task.create(name: d[4], start_at: start_at, end_at: end_at, project: project)
  p t
end
