class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    original_path = super
    if Flipper[:beta_search].enabled?(current_user) && original_path == "/"
      "/multiplier/search"
    else
      original_path
    end
  end
end
