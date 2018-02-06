class TasksController < ApplicationController
  def index
    if current_user
      @incomplete_tasks = current_user.tasks.where(complete: false)
      @complete_tasks   = current_user.tasks.where(complete: true)
    end
  end

  def create
    #code
  end

  def update
    #code
  end

  def create
    #code
  end

  private

    def task_params
      #code
    end
end
