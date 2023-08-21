# frozen_string_literal: true

class EventNoticeMailer < ApplicationMailer
  def notification_mail
    @user = params[:user]
    @event = params[:event]
    mail(
      subject: 'Twetter通知',
      to: @user.email
    )
  end
end
