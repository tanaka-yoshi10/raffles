require 'rails_helper'

describe Task do
  it "returns time by second" do
    task = Task.new(
      name: "task",
      start_at: Time.new(2014,10,10,10,10,10),
      end_at: Time.new(2014,10,10,10,10,20))
    expect(task.time_second).to eq(10)
  end

  it "returns tasks with start date" do
    task1 = Task.create(
      name: "task1",
      start_at: Time.new(2014,10,10,10,10,10),
      end_at: Time.new(2014,10,11,10,10,20))
    task2 = Task.create(
      name: "task2",
      start_at: Time.new(2014,10,10,10,10,10),
      end_at: Time.new(2014,10,10,10,10,20))
    task3 = Task.create(
      name: "task3",
      start_at: Time.new(2014,10,9,10,10,10),
      end_at: Time.new(2014,10,10,10,10,20))
    task4 = Task.create(
      name: "task4",
      start_at: Time.new(2014,10,11,23,59,59),
      end_at: Time.new(2014,10,12,10,10,20))
    task5 = Task.create(
      name: "task5",
      start_at: Time.new(2014,10,12,0,0,0),
      end_at: Time.new(2014,10,12,10,10,20))

    expect(Task.between("2014/10/10 - 2014/10/11")).to eq([task1, task2, task4])
  end
end
