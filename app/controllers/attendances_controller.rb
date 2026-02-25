class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :ensure_event_admin, only: [:index]

  def new
    if current_user == @event.admin
      return redirect_to @event, alert: t("app.attendances.errors.admin_cannot_join")
    end
    if @event.participants.include?(current_user)
      return redirect_to @event, alert: t("app.attendances.errors.already_joined")
    end
    if @event.is_free?
      return redirect_to @event, alert: t("app.attendances.errors.free_event")
    end
  end

  def create
    # Uniquement pour les événements gratuits (les payants passent par checkout -> success)
    unless @event.is_free?
      redirect_to @event, alert: t("app.attendances.errors.use_checkout")
      return
    end

    @attendance = Attendance.new(user: current_user, event: @event)

    if @attendance.save
      redirect_to @event, notice: t("app.flash.attendance_created")
    else
      redirect_to @event, alert: @attendance.errors.full_messages.join(", ")
    end
  end

  def index
    @attendances = @event.attendances.includes(:user)
  end

  def checkout
    if @event.is_free?
      redirect_to @event, alert: t("app.attendances.errors.free_event")
      return
    end
    if current_user == @event.admin
      redirect_to @event, alert: t("app.attendances.errors.admin_cannot_join")
      return
    end
    if @event.participants.include?(current_user)
      redirect_to @event, alert: t("app.attendances.errors.already_joined")
      return
    end

    session_stripe = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "eur",
          product_data: {
            name: @event.title,
            description: @event.description.truncate(500)
          },
          unit_amount: @event.price * 100 # Stripe attend des centimes
        },
        quantity: 1
      }],
      mode: "payment",
      success_url: event_attendance_success_url(@event) + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: event_url(@event) + "?canceled=true",
      client_reference_id: current_user.id.to_s,
      customer_email: current_user.email
    )

    redirect_to session_stripe.url, allow_other_host: true
  end

  def success
    if @event.is_free?
      redirect_to @event
      return
    end

    session_id = params[:session_id]
    if session_id.blank?
      redirect_to @event, alert: t("app.attendances.errors.payment_failed")
      return
    end

    stripe_session = Stripe::Checkout::Session.retrieve(session_id)

    unless stripe_session.payment_status == "paid"
      redirect_to @event, alert: t("app.attendances.errors.payment_failed")
      return
    end

    # Vérifier que le paiement correspond à cet événement et à l'utilisateur connecté
    if stripe_session.amount_total != @event.price * 100
      return redirect_to @event, alert: t("app.attendances.errors.payment_failed")
    end
    if stripe_session.client_reference_id != current_user.id.to_s
      return redirect_to @event, alert: t("app.attendances.errors.payment_failed")
    end

    @attendance = Attendance.new(
      user: current_user,
      event: @event,
      stripe_customer_id: stripe_session.customer
    )

    if @attendance.save
      redirect_to @event, notice: t("app.flash.attendance_created")
    else
      redirect_to @event, alert: @attendance.errors.full_messages.join(", ")
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def ensure_event_admin
    return if current_user == @event.admin

    redirect_to root_path, alert: t("app.flash.event_forbidden")
  end
end
