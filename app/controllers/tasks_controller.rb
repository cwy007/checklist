class TasksController < ApplicationController
  def index
    if current_user
      @incomplete_tasks = current_user.tasks.where(complete: false)
      @complete_tasks   = current_user.tasks.where(complete: true)
    end
  end

  def create
    @task = current_user.tasks.create!(task_params)

    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update_attributes!(task_params)

    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.js
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :complete)
    end
end
