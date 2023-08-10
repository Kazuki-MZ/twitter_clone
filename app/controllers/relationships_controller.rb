# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    current_user.active_relationships.create!(followed_id: params[:followed_id])
    redirect_back(fallback_location: root_path)
    flash[:success] = 'フォローしました'
  end

  def destroy
    following_user = current_user.active_relationships.find_by!(followed_id: params[:followed_id])
    following_user.destroy!
    redirect_back(fallback_location: root_path)
    flash[:success] = 'フォロー外しました'
  end
end
