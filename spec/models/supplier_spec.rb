require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando razão social está vazio' do
        supplier = Supplier.new(corporate_name:'', brand_name:'blabla', 
                                registration_number:'1234567898765', state:'MG',
                                full_address:'Rua Laranja,43', city:'São Thomé das Letras', 
                                email:'blabla@blabla.com')
        
        expect(supplier).not_to be_valid
      end
      
      it 'falso quando email está vazio' do
        supplier = Supplier.new(corporate_name:'blablabla', brand_name:'blabla2', 
                                registration_number:'1234567898765', state:'MG',
                                full_address:'Rua Tangerina, 43', city:'São Thomé das Letras', 
                                email:'')
        
          expect(supplier).not_to be_valid
      end
      it 'falso quando CNPJ está vazio' do
        supplier = Supplier.new(corporate_name:'blablabla', brand_name:'blabla2', 
                                registration_number:'', state:'MG',
                                full_address:'Rua Goiaba, 32', city:'São Thomé das Letras', 
                                email:'blablabla@blabla')
        
        expect(supplier).not_to be_valid
      end
    end
    context 'uniqueness' do
      it 'falso quando CNPJ já está em uso' do
        supplier = Supplier.create!(corporate_name:'blablabla', brand_name:'blabla2', 
                                    registration_number:'1239086438923', state:'MG',
                                    full_address:'Rua Abacaxi, 67', city:'São Thomé das Letras', 
                                    email:'blablabla@blabla')
        second_supplier = Supplier.new(corporate_name:'banana', brand_name:'abacate', 
                                       registration_number:'1239086438923', state:'MG',
                                       full_address:'Rua Melão, 444', city:'Três Corações', 
                                       email:'blablabla@blabla2')

        expect(second_supplier).not_to be_valid

      end
    end
    context 'length' do
      it 'falso quando tamanho do CNPJ é maior que 13" format' do
        supplier = Supplier.new(corporate_name:'blablabla', brand_name:'blabla2', 
                                registration_number:'57483', state:'MG',
                                full_address:'Rua Morango,897', 
                                city:'São Thomé das Letras', 
                                email:'blablabla@blabla')                                           
          expect(supplier).not_to be_valid
      end
    end
  end
end