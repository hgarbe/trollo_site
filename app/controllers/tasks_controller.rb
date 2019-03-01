class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
  end

  def show
  end

  def new
    @task = Task.new
    render partial: 'form'
  end

  def create
    @task = @list.tasks.new(task_params)
    if @task.save
      redirect_to board_list_path(@list.board_id, @list)
    else
      render :new
    end
  end

  def edit
    render partial: 'form'
  end

  def update
    if @task.update(task_params)
      redirect_to board_list_path(@list.board_id, @list)
    else
      render :edit
    end
  end


  def destroy

    @task.destroy
    redirect_to board_list_path(@list.board_id, @list)
  end

  private
    def set_list
      @list = List.find(params[:list_id])
    end
    
    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
      params.require(:task).permit(:name, :body)
    end
end
