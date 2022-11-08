class Api::V1::ApiController < ActionController::API 
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500   

  def return_500 
    render status: 500
  end 

  def return_404 
    render status: 404
  end
end