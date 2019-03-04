class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:edit, :update, :destroy]

  def new
    @task = @list.tasks.new
  end

  def create
    @list.tasks.new(task_params).save
    redirect_to board_path(@list.board_id)
  end

  def edit
  end

  def update
    Task.update_task(@task.id, task_params)
    redirect_to board_path(@list.board_id)
  end

  def destroy
    @task.destroy
    redirect_to board_path(board_id)
  end

  private
    def set_task
      @task = Task.single_task(params[:id])
    end

    def set_list
      @list = List.single_list(params[:list_id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :priority)
    end

end