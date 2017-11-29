class IslandsController < ApplicationController
  before_action :set_island, only: [:show, :edit, :update]

  def index
    @islands = Island.all
  end

  def new
    @island = Island.new
  end

  def create
    @island = Island.new(island_params)
    @island.user_id = current_user.id

    if @island.save
      redirect_to @island, notice: 'Island was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @island.update(island_params)
      redirect_to @island, notice: 'Island was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_island
      @island = Island.find(params[:id])
    end

    def island_params
      params.require(:island).permit(:title, :description)
    end
end
