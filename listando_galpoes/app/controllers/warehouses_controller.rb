<<<<<<< HEAD
class WarehousesController < ApplicationController 
  def index 
    @warehouses = []
    response = Faraday.get('http://localhost:4000/api/v1/warehouses')
    @data = response.body
=======
class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
   
  def show; end  
  def edit; end
  
  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)  
    if @warehouse.save                                         
      redirect_to root_path, notice: 'Galpão cadastrado com sucesso'
    else
      flash.now[:notice] = 'Galpão não cadastrado'
      render 'new'
    end
  end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse)
    else
      flash.now[:notice] = 'Não foi possível cadastrar o galpão'
      render 'edit'
    end
  end

  def destroy
    @warehouse.delete
    redirect_to root_path, notice: 'Galpão removido com sucesso'
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    w_params = params.require(:warehouse).permit(:name, :code, :city, :description,
                                                 :address, :cep, :area)
>>>>>>> 015da33165c05d6f2af0455957a6c0ef3e4a2126
  end
end