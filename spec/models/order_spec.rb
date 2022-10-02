require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do    
      it 'false when supplier is nil' do
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')
        warehouse = Warehouse.create!(name: 'Galpão Brazil', code: 'BRA', city: 'Goiânia',
                                       area: 100_000, address: 'Avenida Marechal Deodoro, 100', 
                                       cep: '15000-000', description: 'Galpão destinado para cargas 
                                      internacionais')

        code = Array.new(20){[*"A".."Z",*"0".."9"].sample}.join
        order = Order.new(warehouse_id: warehouse.id, supplier_id: nil, 
                              estimated_delivery_date: "#{Date.today+1}", user_id: user.id, 
                              order_code:"#{code}")
                     
        expect(order).not_to be_valid
      end
    end
      it 'false when warehouse is nil' do
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                    registration_number: '6778075000107', state: 'SP', 
                                    full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                    email: 'contato@acme.com.br')

        code = Array.new(20){[*"A".."Z",*"0".."9"].sample}.join
        order = Order.new(warehouse_id: nil, supplier_id: supplier.id, 
                              estimated_delivery_date: "#{Date.today+1}", user_id: user.id, 
                              order_code:"#{code}")
                     
        expect(order).not_to be_valid
      end
      it 'false when estimated delivery date is blank' do
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')

        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                    registration_number: '6778075000107', state: 'SP', 
                                    full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                    email: 'contato@acme.com.br')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                      area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                      cep: '15000-000', description: 'Galpão destinado para cargas 
                                      internacionais')

        code = Array.new(20){[*"A".."Z",*"0".."9"].sample}.join
        order = Order.new(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                              estimated_delivery_date: "mm/dd/yyyy", user_id: user.id, 
                              order_code:"#{code}")
                     
        expect(order).not_to be_valid
      end
    end
    context 'length' do
      it 'code length must be equal to 20' do
        user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                      area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                      cep: '15000-000', description: 'Galpão destinado para cargas 
                                      internacionais')
    
        supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                    registration_number: '6778075000107', state: 'SP', 
                                    full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                    email: 'contato@acme.com.br')
        code = Array.new(21){[*"A".."Z",*"0".."9"].sample}.join                            
                                    
        order = Order.new(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                              estimated_delivery_date: "#{Date.today+1}", user_id: user.id, 
                              order_code:"#{code}")                           
        
        expect(order).not_to be_valid
      end
    end
  end