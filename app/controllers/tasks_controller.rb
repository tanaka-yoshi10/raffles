class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.order(:start_at)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  require 'csv'
  def report_by_day
    if params[:day].blank?
      @tasks = Task.by_month(Time.new(params[:year],params[:month]))
    else
      @tasks = Task.by_start_date(Time.new(params[:year],params[:month],params[:day]))
    end

    if params[:commit] == "csv"
      header = ['作業名', '作業時間', 'プロジェクトコード']
      generated_csv = CSV.generate(row_sep: "\r\n") do |csv|
        csv << header
        @tasks.each do |task|
          csv << [task.name, task.time_second / 60, task.project.code]
        end
      end

      send_data generated_csv.encode(Encoding::CP932, invalid: :replace, undef: :replace),
        filename: 'zaiko.csv',
        type: 'text/csv; charset=shift_jis'

      return
    end

    @report = @tasks.inject(Hash.new(0)) {|r, task| r[task.project] += task.time_second; r}
    render :index
  end

  def top
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :start_at, :end_at, :project_id)
    end
end
