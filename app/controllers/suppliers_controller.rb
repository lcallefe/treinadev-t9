class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]
  def index
    @suppliers = Supplier.all
  end

  def new

  end

  def show

  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end
end