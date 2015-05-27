require 'rails_helper'

feature 'Task management' do
  scenario "adds a new task" do
    visit new_task_path
    fill_in 'Name', with: "test"
    fill_in 'Date', with: "2015-04-10"
    fill_in 'Starttime', with: "15:00"
    fill_in 'Endtime', with: "16:00"
    click_button 'Create Task'
  end
end
