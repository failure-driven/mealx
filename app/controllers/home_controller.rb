class HomeController < ApplicationController
  def index
    @variant = variants.sample
  end

  def show
    if variants.include? params[:id].to_sym
      @variant = params[:id].to_sym
    else
      redirect_to root_path
    end
  end

  private

  def variants
    [:dish_finder, :fish_the_dish, :meal_mate, :mealx]
  end
end
