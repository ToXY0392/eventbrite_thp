class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_event_admin, only: [:edit, :update, :destroy]

  def index
    @events = Event.validated.order(start_date: :asc)
  end

  def show
    return redirect_to root_path, alert: t("app.events.show.unvalidated") unless @event.validated?

    @attendees_count = @event.attendances.count
    if params[:canceled] == "true"
      flash.now[:alert] = t("app.attendances.errors.payment_canceled")
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user

    if @event.save
      redirect_to @event, notice: t("app.flash.event_created_pending")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: t("app.flash.event_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path, notice: t("app.flash.event_destroyed")
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def ensure_event_admin
    redirect_to root_path, alert: t("app.flash.event_forbidden") unless current_user == @event.admin
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location, :picture)
  end
end
