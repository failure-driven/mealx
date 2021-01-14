class HomeController < ApplicationController
  def index
    if Flipper.enabled?(:pre_launch_signup)
      @variant = variants.sample
      @name = @variant.to_s.humanize
    else
      @variant = :coming_soon
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

  private

  def variants
    [:dish_finder, :fish_the_dish, :meal_mate, :mealx]
  end
end
