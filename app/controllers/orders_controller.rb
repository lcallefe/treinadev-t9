class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update]
  before_action :populate_variables, only: [:new, :edit, :update]
  before_action :validate_user, only: [:show, :edit, :update]

  def new
    @order = Order.new
  end

  def index
    @orders = Order.all
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to order_path(@order.id), notice: "Pedido alterado com sucesso."
    else
      flash.now[:notice] = 'Não foi possível alterar pedido'
      render 'edit'
    end
  end

  def create
    order_params
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: "Pedido registrado com sucesso."
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível realizar o pedido'
      render 'new'
    end
  end

  def show
  end

  def order_params
    order_params = params.require(:order).permit(:warehouse_id, 
                                  :supplier_id, :estimated_delivery_date)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def populate_variables
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def validate_user
    if !user_signed_in? || current_user.id != @order.user_id
      redirect_to orders_path, notice: 'Cadastre-se ou faça login para visualizar este pedido.'
    end
  end
end