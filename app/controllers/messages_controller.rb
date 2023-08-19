# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_room, :set_messages, only: %i[index create]
  def index
    @message = Message.new
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_back(fallback_location: root_path)
    else
      render 'messages/index', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:text).merge(room_id: params[:room_id])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_messages
    @messages = Message.where(room_id: @room.id).page(params[:page]).per(8)
  end
end
