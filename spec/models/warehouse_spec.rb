require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        warehouse = Warehouse.new(name:'', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        
        expect(warehouse).not_to be_valid
      end
      
      it 'false when code is empty' do
        warehouse = Warehouse.new(name:'Rio de Janeiro', code: '', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        
        expect(warehouse).not_to be_valid

      end
      it 'false when address is empty' do
        warehouse = Warehouse.new(name:'Rio de Janeiro', code: 'RIO', address: '',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        
        expect(warehouse).not_to be_valid
      end
    end
    context 'uniqueness' do
      it 'false when code is already in use' do
        warehouse = Warehouse.create(name:'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        second_warehouse = Warehouse.new(name:'Angra dos Reis', code: 'RIO', address: 'Endereço',
                                         cep: '25000-000', city: 'Rio', area: 1000,
                                         description: 'Alguma descrição')

        expect(second_warehouse).not_to be_valid

      end
      it 'false when name is already in use' do
        warehouse = Warehouse.create(name:'Angra dos Reis', code: 'ANG', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        second_warehouse = Warehouse.new(name:'Angra dos Reis', code: 'RIO', address: 'Endereço',
                                         cep: '25000-000', city: 'Rio', area: 2000,
                                         description: 'Alguma descrição')

        expect(second_warehouse).not_to be_valid
      end
    end
    context 'format' do
      it 'false when CEP does not match "00000-000" format' do
        warehouse = Warehouse.new(name:'Angra dos Reis', code: 'RIO', address: 'Endereço',
                                  cep: '25000-0000', city: 'Rio', area: 2000,
                                  description: 'Alguma descrição')
                                  
        expect(warehouse).not_to be_valid
      end
      it 'false when code does not match "AAA" format' do
        warehouse = Warehouse.new(name:'Angra dos Reis', code: 'ANGRA', address: 'Endereço',
                                  cep: '25000-0000', city: 'Rio', area: 2000,
                                  description: 'Alguma descrição')
                                  
        expect(warehouse).not_to be_valid
      end
    end
  end
end