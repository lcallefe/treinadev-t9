require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando nome está vazio' do
        warehouse = Warehouse.new(name:'', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        
        expect(warehouse).not_to be_valid
      end
      
      it 'falso quando código está vazio' do
        warehouse = Warehouse.new(name:'Rio de Janeiro', code: '', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        
          expect(warehouse).not_to be_valid
        end
      end
      it 'falso quando endereço está vazio' do
        warehouse = Warehouse.new(name:'Rio de Janeiro', code: 'RIO', address: '',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        
        expect(warehouse).not_to be_valid
      end
    end
    context 'uniqueness' do
      it 'falso quando código já está em uso' do
        warehouse = Warehouse.create(name:'Rio de Janeiro', code: 'RIO', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        second_warehouse = Warehouse.new(name:'Angra dos Reis', code: 'RIO', address: 'Endereço',
                                         cep: '25000-000', city: 'Rio', area: 1000,
                                         description: 'Alguma descrição')

        expect(second_warehouse).not_to be_valid

      end
      it 'falso quando nome já está em uso' do
        warehouse = Warehouse.create(name:'Angra dos Reis', code: 'ANG', address: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        second_warehouse = Warehouse.new(name:'Angra dos Reis', code: 'RIO', address: 'Endereço',
                                         cep: '25000-000', city: 'Rio', area: 2000,                                         description: 'Alguma descrição')
        expect(second_warehouse).not_to be_valid
      end
    end
    context 'format' do
      it 'falso quando CEP não corresponde ao formato "00000-000"' do
        warehouse = Warehouse.new(name:'Angra dos Reis', code: 'RIO', address: 'Endereço',
                                  cep: '25000-0000', city: 'Rio', area: 2000,
                                  description: 'Alguma descrição')                                            
          expect(warehouse).not_to be_valid
      end
      it 'falso quando código não corresponde ao formato AAA' do
        warehouse = Warehouse.new(name:'Angra dos Reis', code: 'ANGRA', address: 'Endereço',
                                  cep: '25000-0000', city: 'Rio', area: 2000,
                                  description: 'Alguma descrição')                                                           
        expect(warehouse).not_to be_valid
      end
    end
  describe '#full_description' do
    it 'exibe o nome e o código' do
      # Arrange
      w = Warehouse.new(name: 'Galpão Cuiaba', code: 'CBA', )
      # Act
      result = w.full_description

      # Assert
      expect(result).to eq ('CBA - Galpão Cuiaba')
    end 

  end
  
  end