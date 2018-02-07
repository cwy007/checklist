class TasksController < ApplicationController
  def index
    if current_user
      @incomplete_tasks = current_user.tasks.where(complete: false)
      @complete_tasks   = current_user.tasks.where(complete: true)
    end
  end

  def create
    @task = current_user.tasks.create!(task_params)
    redirect_to tasks_path
  end

  def update
    #code
  end

  def destroy
    #code
  end

  private

    def task_params
      params.require(:task).permit(:name, :complete)
    end
end
