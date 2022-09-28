require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
  # Arrange
   s = Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                         registration_number: '6778075000103', state: 'SP',
                         full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                         email: 'samsung@samsung.com.br')
  # Act
  visit root_path
  click_on 'Modelos de Produtos'
  click_on 'Cadastrar Novo'
  fill_in 'Nome', with: 'TV 40 Polegadas'                      
  fill_in 'Peso', with: 10_000
  fill_in 'Altura', with: 60
  fill_in 'Largura', with: 90
  fill_in 'Profundidade', with: 10
  fill_in 'SKU', with: '67594032938291293847'
  select 'banana', from: 'Fornecedor'
  click_on 'Enviar'

  # Assert

  expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
  expect(page).to have_content 'TV 40 Polegadas'
  expect(page).to have_content '67594032938291293847'
  expect(page).to have_content 'Dimensão: 60cm x 90cm'
  expect(page).to have_content 'Peso: 10000g'
  expect(page).to have_content 'Fornecedor: banana'
end 


end