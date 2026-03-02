class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_event_admin, only: [:edit, :update, :destroy]

  def index
    @events = Event.validated.with_attached_picture.order(start_date: :asc)
    @events = @events.where(location: params[:location]) if params[:location].present?
    @cities = Event.validated.group(:location).count.sort_by { |_, count| -count }.first(6)
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
    if current_user.admin?
      @event.validated = true
      @event.reviewed = true
    end

    if @event.save
      redirect_to @event, notice: (current_user.admin? ? t("app.flash.event_created") : t("app.flash.event_created_pending")), allow_other_host: true
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: t("app.flash.event_updated"), allow_other_host: true
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
    p = params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location, :picture)
    p[:price] = 0 if p[:price].to_s.strip.blank?
    p
  end
end
