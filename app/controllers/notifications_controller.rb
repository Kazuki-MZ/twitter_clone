# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order('notifications.created_at DESC').page(params[:page]).per(6)
  end
end
