# frozen_string_literal: true

class RoomsController < ApplicationController
  def create
    @message_partner = User.find(params[:message_partner_id])
    rooms = current_user.room_users.pluck(:room_id)
    room_user = RoomUser.find_by(user_id: @message_partner.id, room_id: rooms)
    if room_user.present?
      redirect_to room_messages_path(room_user.room.id)
    else
      @room = Room.create!
      RoomUser.create!(user_id: current_user.id, room_id: @room.id)
      RoomUser.create!(user_id: @message_partner.id, room_id: @room.id)
      redirect_to room_messages_path(@room.id)
    end
  end
end
