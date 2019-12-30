class ApplicationController < ActionController::Base
  before_action :ransack
  
  def ransack
    @q = Post.ransack(params[:q])
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


  # before_action :configure_permitted_parameters, if: :devise_controller?
  # protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  # end
end
