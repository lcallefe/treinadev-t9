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
    code_first_order = Array.new(20){[*"A".."Z",*"0".."9"].sample}.join
    code_second_order = Array.new(20){[*"A".."Z",*"0".."9"].sample}.join
    code_third_order = Array.new(20){[*"A".."Z",*"0".."9"].sample}.join

    first = Order.create!(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                  estimated_delivery_date: Date.today+1, user_id: user.id, 
                  order_code:"#{code_first_order}")
    second = Order.create!(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                  estimated_delivery_date: Date.today+2, user_id: user.id, 
                  order_code:"#{code_second_order}")
    third = Order.create!(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                  estimated_delivery_date: Date.today+1, user_id: user.id, 
                  order_code:"#{code_third_order}")

    # Act
    visit root_path
    login_as(user)
    click_on 'Ver pedidos'
   
    # Assert
    expect(page).to have_content("#{code_first_order}")
    expect(page).to have_content("#{code_second_order}")
    expect(page).to have_content("#{code_third_order}")
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
    code = Array.new(20){[*"A".."Z",*"0".."9"].sample}.join

    Order.create!(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                  estimated_delivery_date: Date.today+1, user_id: user.id, 
                  order_code:"#{code}")
  
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