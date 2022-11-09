class Api::V1::WarehousesController < Api::V1::ApiController
  def show 
    id = params[:id]
    response = Faraday.get("http://localhost:4000/api/v1/warehouses/#{id}")
  end

  def index 
    response = Faraday.get("http://localhost:4000/api/v1/warehouses")
    if response.status == 200 
      @warehouses = JSON.parse(response.body)
    else  
      redirect_to root_path
    end
  end

  def create  
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, 
                                                          :address, :description, 
                                                          :area, :cep)
    warehouse = Warehouse.new(warehouse_params)

    if warehouse.save
      render status: 201, json: warehouse
    else  
      render status: 412, json: { errors: warehouse.errors.full_messages }
    end
  end
end