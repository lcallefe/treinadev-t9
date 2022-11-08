class ApplicationController < ActionController::Base
<<<<<<< HEAD
=======
  before_action :authenticate_user!, only: [:index, :edit, :show, :create, :new]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
>>>>>>> 015da33165c05d6f2af0455957a6c0ef3e4a2126
end
