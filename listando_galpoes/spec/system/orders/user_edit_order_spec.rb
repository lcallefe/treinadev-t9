require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'a partir da tela de pedidos' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password', name: 'Luciana')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '6778075000107', state: 'SP', 
                                full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                email: 'contato@acme.com.br')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                     registration_number: '6778075030107', state: 'MG', 
                     full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                     email: 'contato@acme.com.br')
    warehouse = Warehouse.create!(name: 'Aeroporto BH', code: 'GRH', city: 'Guarulhos',
                                  area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                  cep: '15000-000', description: 'Galpão destinado para cargas 
                                                                              internacionais')
    Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                      area: 100_000, address: 'Avenida do Aeroporto, 100', 
                      cep: '15000-000', description: 'Galpão destinado para cargas 
                                                                              internacionais')                                                                         
    order = Order.new(warehouse: warehouse, supplier: supplier, 
                  estimated_delivery_date: Date.today+1, user: user)
    
    date = Date.today+5
    # Act
    order.save!
    login_as(user)
    visit orders_path
    click_on "#{order.order_code}"
    click_on 'Editar'
    select 'GRH - Aeroporto BH', from: 'Galpão Destino'
    select 'ACME - MG', from: 'Fornecedor'
    fill_in 'Data Prevista', with: date
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido alterado com sucesso.'
    expect(page).to have_content 'Galpão Destino: GRH - Aeroporto BH'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Usuário responsável: Luciana - luciana@gmail.com'
    expect(page).to have_content "Data Prevista de Entrega: #{I18n.localize(date)}"
    expect(page).not_to have_content 'Cadastre-se ou faça login para visualizar este pedido.'
  end
  it 'e não está autorizado' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password', name:'Maria')
    other_user = User.create!(email: 'rafael@gmail.com', password: 'password')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '6778075000107', state: 'SP', 
                                full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                email: 'contato@acme.com.br')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                  area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                  cep: '15000-000', description: 'Galpão destinado para cargas 
                                  internacionais')
    order = Order.new(warehouse: warehouse, supplier: supplier, 
                  estimated_delivery_date: Date.today+1, user: user)

    
    # Act
    order.save!
    login_as(other_user)
    visit root_path
    click_on 'Ver pedidos'
    click_on "#{order.order_code}"

    # Assert
    expect(page).to have_content('Cadastre-se ou faça login para visualizar este pedido.')
    expect(page).not_to have_field('Nome Fantasia', with: 'ACME')
    expect(page).not_to have_content('Pedido registrado com sucesso.')
  end
end