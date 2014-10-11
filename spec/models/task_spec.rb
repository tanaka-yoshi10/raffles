require 'rails_helper'

describe Task do
  it "returns time by second" do
    task = Task.new(
      start_at: "2014/10/10 10:10:10",
      end_at: "2014/10/10 10:10:20")
    expect(task.time_second).to eq(10)
  end
end