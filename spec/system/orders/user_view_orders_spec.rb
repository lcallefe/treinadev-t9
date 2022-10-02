require 'rails_helper'

describe 'Usuáro vê pedidos' do
  it 'a partir da tela principal' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password', name: 'luciana')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '6778075000107', state: 'SP', 
                                full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                email: 'contato@acme.com.br')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                  area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                  cep: '15000-000', description: 'Galpão destinado para cargas 
                                  internacionais')

    first = Order.new(warehouse_id: warehouse, supplier_id: supplier, 
                  estimated_delivery_date: Date.today+1, user_id: user)
    second = Order.new(warehouse_id: warehouse, supplier_id: supplier, 
                  estimated_delivery_date: Date.today+2, user_id: user)
    third = Order.new(warehouse_id: warehouse, supplier_id: supplier, 
                  estimated_delivery_date: Date.today+1, user_id: user)

    # Act
    visit root_path
    login_as(user)
    click_on 'Ver pedidos'
   
    # Assert
    expect(page).to have_content(first.order_code)
    expect(page).to have_content(second.order_code)
    expect(page).to have_content(third.order_code)
  end
  it 'e volta para a tela inicial' do
        # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password', name: 'luciana')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '6778075000107', state: 'SP', 
                                full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                email: 'contato@acme.com.br')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                  area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                  cep: '15000-000', description: 'Galpão destinado para cargas 
                                  internacionais')
 
    Order.create(warehouse_id: warehouse, supplier_id: supplier, 
                  estimated_delivery_date: Date.today+1, user_id: user)
  
    # Act
    visit root_path
    login_as(user)
    click_on 'Ver pedidos'
    click_on 'Galpões & Estoque'
   
    # Assert
    expect(page).to have_content("Fornecedores")
    expect(page).to have_content("Modelos de Produtos")
    expect(page).to have_content("Registrar pedido")
    expect(page).to have_content("Ver pedidos")
    expect(page).to have_content("luciana - luciana@gmail.com")
    expect(current_path).to eq(root_path)
  end
  it 'e não há produtos cadastrados' do
        # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password', name: 'luciana')

    # Act
    visit root_path
    login_as(user)
    click_on 'Ver pedidos'
 
    # Assert
    expect(page).to have_content("Pedidos")
    expect(page).to have_content("Modelos de Produtos")
    expect(page).to have_content("Registrar pedido")
    expect(page).to have_content("Ver pedidos")
    expect(page).to have_content("luciana - luciana@gmail.com")
    expect(current_path).to eq(orders_path)
  end
end