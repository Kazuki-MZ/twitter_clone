# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(_resource)
    tweets_path
  end

  def after_confirmation_path_for(_resource_name, _resource)
    tweets_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    added_attrs = %i[name telephone_number date_of_birth]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
