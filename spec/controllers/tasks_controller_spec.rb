require 'rails_helper'

RSpec.describe TasksController, :type => :controller do

  let(:thismonth_attributes) {
    {name: "this month", start_at: '2015-04-25 17:00:00 GMT', end_at: '2015-4-25 18:00:00 GMT'}
  }
  let(:lastmonth_attributes) {
    {name: "last month", start_at: '2015-03-25 17:00:00 GMT', end_at: '2015-3-25 18:00:00 GMT'}
  }
  let(:valid_attributes) {
    {name: "aaaaa", start_at: '2015-05-25 17:00:00 GMT', end_at: '2015-5-25 18:00:00 GMT'}
  }
  let(:post_attributes) {
    {name: "aaaaa", date: '2015-05-25', starttime: '17:00', endtime: '18:00'}
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns tasks of this month as @tasks" do
      task = Task.create! thismonth_attributes
      Task.create! lastmonth_attributes

      date = Date.new(2015,04,10)
      Timecop.travel(date)

      get :index, {}, valid_session
      expect(assigns(:tasks)).to eq([task])

      Timecop.return
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
      task = Task.create! valid_attributes
      get :show, {:id => task.to_param}, valid_session
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      get :new, {}, valid_session
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      task = Task.create! valid_attributes
      get :edit, {:id => task.to_param}, valid_session
      expect(assigns(:task)).to eq(task)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, {:task => post_attributes}, valid_session
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, {:task => post_attributes}, valid_session
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).to be_persisted
      end

      it "redirects to the created task" do
        post :create, {:task => post_attributes}, valid_session
        expect(response).to redirect_to(tasks_url)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "assigns the requested task as @task" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => post_attributes}, valid_session
        expect(assigns(:task)).to eq(task)
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        put :update, {:id => task.to_param, :task => post_attributes}, valid_session
        expect(response).to redirect_to(task)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :destroy, {:id => task.to_param}, valid_session
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete :destroy, {:id => task.to_param}, valid_session
      expect(response).to redirect_to(tasks_url)
    end
  end

end
