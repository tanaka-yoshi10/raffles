require 'rails_helper'

describe Task do
  it "returns time by second" do
    task = Task.new(
      start_at: "2014/10/10 10:10:10",
      end_at: "2014/10/10 10:10:20")
    expect(task.time_second).to eq(10)
  end

  it "returns tasks with start date" do
    task1 = Task.new(
      start_at: "2014/10/10 10:10:10",
      end_at: "2014/10/11 10:10:20")
    task2 = Task.new(
      start_at: "2014/10/10 10:10:10",
      end_at: "2014/10/10 10:10:20")
    task3 = Task.new(
      start_at: "2014/10/9 10:10:10",
      end_at: "2014/10/10 10:10:20")

    expect(Task.by_start_date("2014/10/10")).to eq([task1, task2])
  end
end