class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_comment, only: [:destroy]
  before_action :ensure_comment_author, only: [:destroy]

  def create
    @comment = @event.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @event, notice: t("app.comments.created"), allow_other_host: true
    else
      redirect_to @event, alert: @comment.errors.full_messages.to_sentence, allow_other_host: true
    end
  end

  def destroy
    @comment.destroy
    redirect_to @event, notice: t("app.comments.destroyed"), allow_other_host: true
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
    redirect_to root_path, alert: t("app.events.show.unvalidated") unless @event.validated?
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def ensure_comment_author
    redirect_to @event, alert: t("app.flash.profile_forbidden"), allow_other_host: true unless @comment.user == current_user
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
