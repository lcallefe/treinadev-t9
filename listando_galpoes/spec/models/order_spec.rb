require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'presence' do    
      it 'falso quando fornecedor é vazio' do
        # Arrange
        order = Order.new(supplier: nil)
        # Act
        order.valid?
        # Assert
        expect(order.errors.include?(:supplier)).to be true  
        expect(order.errors[:supplier]).to include("é obrigatório(a)")
      end
    end
      it 'falso quando galpão é vazio' do
        # Arrange
        order = Order.new(warehouse: nil)
        # Act
        order.valid?
        # Assert
        expect(order.errors.include?(:warehouse)).to be true 
        expect(order.errors[:warehouse]).to include("é obrigatório(a)")        
      end
      it 'falso quando data estimada de entrega está em branco' do
        # Arrange
        order = Order.new(estimated_delivery_date: '')
        # Act
        order.valid?
        # Assert
        expect(order.errors.include?(:estimated_delivery_date)).to be true  
        expect(order.errors[:estimated_delivery_date]).to include("deve ser preenchida e estar no formato dd/mm/yyyy.")
      end
      it 'falso quando data estimada de entrega está no passado' do
        # Arrange
        order = Order.new(estimated_delivery_date: 1.day.ago)
        # Act
        order.valid?
        # Assert
        expect(order.errors.include?(:estimated_delivery_date)).to be true         
        expect(order.errors[:estimated_delivery_date]).to include("deve ser uma data futura.")
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
      order = Order.new(user:user, warehouse:warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now) 
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
        order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

        # Act
        order.save!

        # Assert
        expect(order.order_code).not_to be_empty
        expect(order.order_code.length).to eq 8
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