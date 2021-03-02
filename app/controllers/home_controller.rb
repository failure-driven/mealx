class HomeController < ApplicationController
  def index
    if Flipper.enabled?(:pre_launch_signup)
      @variant = variants.sample
      @name = @variant.to_s.humanize
    else
      # @variant = :coming_soon
      @variant = :landing
    end
  end

  def show
    if variants.include? params[:id].to_sym
      @variant = params[:id].to_sym
      @name = @variant.to_s.humanize
    else
      redirect_to root_path
    end
  end

  def enable_flip
    # TODO: force a login
    begin
      jwt_payload = JWT.decode(params[:token], Rails.application.secrets.secret_key_base).first
      current_user_id = jwt_payload["id"]
      Flipper[:beta_search].enable current_user if current_user && current_user.id == current_user_id
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      # head :unauthorized
    end
    redirect_to root_path
  end

  def disable_flip
    # TODO: force a login
    begin
      jwt_payload = JWT.decode(params[:token], Rails.application.secrets.secret_key_base).first
      current_user_id = jwt_payload["id"]
      Flipper[:beta_search].disable current_user if current_user && current_user.id == current_user_id
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      # head :unauthorized
    end
    redirect_to root_path
  end

  private

  def variants
    [:dish_finder, :fish_the_dish, :meal_mate, :mealx]
  end
end
