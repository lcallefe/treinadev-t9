require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@gmail.com', password: '12345678')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                  area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                  cep: '15000-000', description: 'Galpão destinado para cargas 
                                  internacionais')
    Warehouse.create!(name: 'Galpão Maceio', code: 'AAA', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '6778075000107', state: 'SP', 
                                full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                email: 'contato@acme.com.br')
    Supplier.create!(corporate_name: 'eletrônicos', brand_name: 'banana', 
                     registration_number: '6778075000103', state: 'SP',
                     full_address: 'Avenida do Aeroporto, 1000', city: 'Diadema',
                     email: 'samsung@samsung.com.br')
    
            
      
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select 'ACME - SP', from: 'Fornecedor'
    fill_in 'Data Prevista', with: '20/12/2022'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Usuário responsável: Sergio - sergio@gmail.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'eletrônicos'
    expect(page).not_to have_content 'Galpão Maceio'

  end

end