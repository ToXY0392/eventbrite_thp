class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.order(start_date: :asc)
  end

  def show
    @event = Event.find(params[:id])
    @attendees_count = @event.attendances.count
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user

    if @event.save
      redirect_to @event, notice: t("app.flash.event_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location)
  end
end
