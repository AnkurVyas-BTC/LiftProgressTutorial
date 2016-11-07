class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    page = params[:page] || 1
    @tasks = Task.order(created_at: :desc).page(page).per(10)
    @status_arr = Task.statuses.keys.each_with_object({}) { |status, arr| arr[status] = Task.try(status).count; arr }
    @users = User.all
    @statuses = Task.statuses.keys.to_a
  end

  def get_stats
    @status_arr = Task.statuses.keys.each_with_object({}) { |status, arr| arr[status] = Task.try(status).count; arr }
    @status_arr[:total_tasks] = Task.count
    @user_stats = []
    User.all.map do |user|
      h = {}
      h[:name] = user.name
      h[:id] = user.id
      Task.statuses.keys.map do |status|
        h[status] = user.tasks.try(status).count
      end
      @user_stats << h
    end
    @user_stats
  end

  def get_tasks
    page = params[:page] || 1
    @tasks = Task.order(created_at: :desc).page(page).per(10)
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description, :status, :user_id)
  end
end
