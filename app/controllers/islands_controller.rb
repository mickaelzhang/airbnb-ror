class IslandsController < ApplicationController
  before_action :set_island, only: [:show, :edit, :update]
  before_action :require_author, only: [:edit, :update]

  def index
    if !params.has_key?(:search)
      @islands = Island.all
    else
      search = params['search']
      @islands = Island.available_between(search['start_date'], search['end_date'])
    end
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
    @booking = Booking.new
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
    def island_params
      params.require(:island).permit(:title, :description)
    end

    def set_island
      @island = Island.find(params[:id])
    end

    # Required to be the author of the island to access those pages
    def require_author
      if current_user.id != @island.user_id
        redirect_to @island
      end
    end
end
