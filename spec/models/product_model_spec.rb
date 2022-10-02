require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                            registration_number: '6778075000103', state: 'SP',
                            full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                            email: 'samsung@samsung.com.br')

        product_model = ProductModel.new(name:'', height:145, width:30, depth:20,
                                        weight:62, sku:'12345678901234567890', supplier_id:s)
        
        expect(product_model).not_to be_valid
      end
      
      it 'false when sku is empty' do
        s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                            registration_number: '6778075000103', state: 'SP',
                            full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                            email: 'samsung@samsung.com.br')
                            
        product_model = ProductModel.new(name:'Jaboticaba', height:145, width:30, depth:20,
                                        weight:62, sku:'', 
                                        supplier_id:s)
        
          expect(product_model).not_to be_valid
        end
      end
      it 'false when weight is empty' do
        s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                             registration_number: '6778075000103', state: 'SP',
                             full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                             email: 'samsung@samsung.com.br')

        product_model = ProductModel.new(name:'Jaboticaba', height:145, width:30, depth:20,
                                         weight:'', sku:'77755588899944456789', supplier_id:s)
        
        expect(product_model).not_to be_valid
      end
    end
    context 'uniqueness' do
      it 'false when sku is already in use' do
        s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                             registration_number: '6778075000103', state: 'SP',
                             full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                             email: 'samsung@samsung.com.br')

        product_model = ProductModel.new(name:'Jaboticaba', height:145, width:30, depth:20,
                                         weight:50, sku:'6778075000103', 
                                         supplier_id:s)

        second_product_model = ProductModel.new(name:'Jaboticaba', height:145, 
                                                width:30, depth:20,
                                                weight:50, sku:'6778075000103', 
                                                supplier_id:s)                                 
        

        expect(second_product_model).not_to be_valid

      end
    end
    context 'length' do
      it 'sku length must be equal to 20' do
        s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                             registration_number: '6778075000103', state: 'SP',
                             full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                             email: 'samsung@samsung.com.br')
        product_model = ProductModel.new(name:'Jaboticaba', height:145, width:30, depth:20,
                                         weight:50, sku:'677807500010', 
                                         supplier_id:s)                                           
        expect(product_model).not_to be_valid
      end
      it 'weight must be greater than 0' do
        s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                             registration_number: '6778075000103', state: 'SP',
                             full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                             email: 'samsung@samsung.com.br')
        product_model = ProductModel.new(name:'Jaboticaba', height:145, width:30, depth:20,
                                         weight:-1, sku:'6778075000101', 
                                         supplier_id:s)                                                           
        expect(product_model).not_to be_valid
      end
      it 'height must be greater than 0'do
        s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                             registration_number: '6778075000103', state: 'SP',
                             full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                             email: 'samsung@samsung.com.br')
        product_model = ProductModel.new(name:'Jaboticaba', height:-1, width:30, depth:20,
                                         weight:10, sku:'6778075000101', 
                                         supplier_id:s)                                                           
        expect(product_model).not_to be_valid
      end
      it 'width must be greater than 0'do
      s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                           registration_number: '6778075000103', state: 'SP',
                           full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                           email: 'samsung@samsung.com.br')
        product_model = ProductModel.new(name:'Jaboticaba', height:0, width:-1, depth:10,
                                         weight:10, sku:'6778075000101', 
                                         supplier_id:s)                                                           
        expect(product_model).not_to be_valid
      end
    end
  end