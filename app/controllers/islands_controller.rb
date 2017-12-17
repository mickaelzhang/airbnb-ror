class IslandsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_island, only: [:show, :edit, :update]
  before_action :require_author, only: [:edit, :update]

  def index
    if params[:search]
      @islands = Island.search(params[:search])
      @islands = @islands.location(params[:location]) if params[:location].present?
    else
      if params[:booking]
        booking = params['booking']
        not_available_islands = Island.not_available_list(booking['start_date'], booking['end_date'])
        excluded_island_id = []

        not_available_islands.each do |i|
          excluded_island_id.push(i.id)
        end

        @islands = Island.where.not(id: excluded_island_id)
      else
        @islands = Island.all
      end
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
    search = params['booking']
    @booking = Booking.new
    if params.has_key?(:booking)
      @is_available = @island.is_available_between(search['start_date'], search['end_date'])
    end
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
      params.require(:island).permit!
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
