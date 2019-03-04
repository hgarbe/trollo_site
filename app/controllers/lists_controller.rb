class ListsController < ApplicationController
  before_action :set_board, except: [:destroy]
  before_action :set_list, only: [:edit, :update, :destroy]

  def index
    @lists = List.all 
  end  

  def new
    @list = @board.lists.new
  end

  def create
    @board.lists.create_list(list_params, @board.id)
    redirect_to @board
  end

  def edit
  end

  def update
    List.update_list(@list.id, list_params)
    redirect_to @board
  end

  def destroy
    @list.destroy
    redirect_to board_path(@list.board_id)
  end

  private
    def set_list
      @list = List.single_list(params[:id])
    end

    def set_board
      @board = Board.single_board(params[:board_id])
    end

    def list_params
      params.require(:list).permit(:title, :priority)
    end
end
