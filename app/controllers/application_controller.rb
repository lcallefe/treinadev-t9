class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:index, :edit, :show, :create, :new]
end
