require 'rails_helper'

describe Task do
  describe '#time_secont' do
    it "returns time by second" do
      task = create(:task,
        start_at: Time.new(2014,10,10,10,10,10),
        end_at: Time.new(2014,10,10,10,10,20))
      expect(task.time_second).to eq(10)
    end
  end

  describe 'Task.between' do
    it "returns tasks with start date" do
      task1 = FactoryGirl.create(:task,
        start_at: Time.new(2014,10,10,10,10,10),
        end_at: Time.new(2014,10,11,10,10,20))
      task2 = create(:task,
        start_at: Time.new(2014,10,10,10,10,10),
        end_at: Time.new(2014,10,10,10,10,20))
      task3 = create(:task,
        start_at: Time.new(2014,10,9,10,10,10),
        end_at: Time.new(2014,10,10,10,10,20))
      task4 = create(:task,
        start_at: Time.new(2014,10,11,23,59,59),
        end_at: Time.new(2014,10,12,10,10,20))
      task5 = create(:task,
        start_at: Time.new(2014,10,12,0,0,0),
        end_at: Time.new(2014,10,12,10,10,20))

      expect(Task.between("2014/10/10 - 2014/10/11")).to eq([task1, task2, task4])
    end
  end
end
