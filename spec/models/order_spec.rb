require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'presence' do    
      it 'falso quando fornecedor é nulo' do
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')
        warehouse = Warehouse.create!(name: 'Galpão Brazil', code: 'BRA', city: 'Goiânia',
                                       area: 100_000, address: 'Avenida Marechal Deodoro, 100', 
                                       cep: '15000-000', description: 'Galpão destinado para cargas 
                                      internacionais')

        order = Order.new(warehouse_id: warehouse, supplier_id: nil, 
                              estimated_delivery_date: Date.today+1, user_id: user)
                     
        expect(order).not_to be_valid
      end
    end
      it 'falso quando galpão é nulo' do
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                    registration_number: '6778075000107', state: 'SP', 
                                    full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                    email: 'contato@acme.com.br')

        order = Order.new(warehouse_id: nil, supplier_id: supplier, 
                              estimated_delivery_date: "#{Date.today+1}", user_id: user)
                     
        expect(order).not_to be_valid
      end
      it 'falso quando data estimada de entrega está em branco' do
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                    registration_number: '6778075000107', state: 'SP', 
                                    full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                    email: 'contato@acme.com.br')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                      area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                      cep: '15000-000', description: 'Galpão destinado para cargas 
                                      internacionais')

        order = Order.new(warehouse_id: warehouse, supplier_id: supplier, 
                              estimated_delivery_date: "mm/dd/yyyy", user_id: user)
                     
        expect(order).not_to be_valid
      end
    end
    it 'deve ter um código' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço',
                                    cep: '25000-000', city: 'São Paulo', area: 1000,
                                    description: 'Alguma descrição')
      supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'1234567890123',
                                  email: 'contato@acme.com', full_address: 'Av das Palmas, 123', city: 'Bauru', state: 'SP')
      order = Order.new(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: Date.today+1) 
      # Act
      result = order.valid?
      # Assert
      expect(result).to be true
    end
    describe 'gera um código aleatório' do
      it 'ao criar um novo pedido' do
        # Arrange
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')
        warehouse = Warehouse.create!(name: 'Galpão Rio', code: 'RIO', address: 'Endereço', cep: '25000-000',
                                      city: 'Rio', area: 1000, description: 'Alguma descrição')
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'1234567890123',
                                    email: 'contato@acme.com', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP')
        order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.today+1)

        # Act
        order.save!
        result = order.order_code

        # Assert
        expect(result).not_to be_empty
        expect(result.length).to eq 8
      end
      it 'e o código é único' do
        # Arrange
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')
        warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço', cep: '25000-000',
                                      city: 'Rio', area: 1000, description: 'Alguma descrição')
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number:'1234567890123',
                                    email: 'contato@acme.com', full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP')
        first_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.today+2)
        second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.today+3)
        # Act
        second_order.save!
        # Assert
        expect(second_order.order_code).not_to eq first_order.order_code
      end
    end
  end