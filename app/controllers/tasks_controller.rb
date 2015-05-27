class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @task = Task.new
    if params[:range].blank?
      @daterange = Date.today.beginning_of_month.strftime('%Y/%m/%d') + ' - ' + Date.today.end_of_month.strftime('%Y/%m/%d')
    else
      @daterange = params[:range]
    end
    @tasks = Task.between(@daterange)

    if params[:commit] == "csv"
      generated_csv = @tasks.to_csv
      send_data generated_csv.encode(Encoding::CP932, invalid: :replace, undef: :replace),
                filename: 'tasks.csv',
                type: 'text/csv; charset=shift_jis'

      return
    end

    @report = @tasks.inject(Hash.new(0)) {|r, task| r[task.project] += task.time_hour; r}
    render :index
  end

  def import
    if params[:csv_file].blank?
      redirect_to(tasks_url, alert: 'インポートするCSVファイルを選択してください')
    else
      num = Task.import(params[:csv_file])
      redirect_to(tasks_url, notice: "#{num.to_s} tasks added or updated")
    end
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
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :date, :starttime, :endtime, :project_id)
    end
end
