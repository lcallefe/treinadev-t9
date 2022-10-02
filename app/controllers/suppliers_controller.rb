class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update]
  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def show

  end

  def edit

  end

  def update
    if @supplier.update(supplier_params)
      redirect_to supplier_path(@supplier)
    else
      flash.now[:notice] = 'Não foi possível alterar fornecedor'
      render 'edit'
    end
  end

  def create
    @supplier = Supplier.new(supplier_params)  
    if @supplier.save                                         
      redirect_to suppliers_path, notice: 'Fornecedor cadastrado com sucesso'
    else
      flash.now[:notice] = 'Fornecedor não cadastrado'
      render 'new'
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    supplier_params = params.require(:supplier).permit(:corporate_name, :brand_name, 
                                                       :registration_number, :state,
                                                       :full_address, :city, :email)
  end
end