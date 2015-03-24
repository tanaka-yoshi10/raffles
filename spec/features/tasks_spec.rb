require 'rails_helper'

feature 'Task management' do
  scenario "adds a new task" do
    visit new_task_path
    fill_in 'Name', with: "test"
    click_button 'Create Task'
  end
end