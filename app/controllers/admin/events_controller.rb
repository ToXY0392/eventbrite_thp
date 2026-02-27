# frozen_string_literal: true

module Admin
  class EventsController < BaseController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    def index
      @events = Event.includes(:admin).order(start_date: :asc)
    end

    def show
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      if @event.save
        redirect_to admin_event_path(@event), notice: t("app.admin.event.created")
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @event.update(event_params)
        redirect_to admin_event_path(@event), notice: t("app.admin.event.updated")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @event.destroy
      redirect_to admin_events_path, notice: t("app.admin.event.destroyed")
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:admin_id, :title, :description, :start_date, :duration, :price, :location, :picture, :validated, :reviewed)
    end
  end
end
