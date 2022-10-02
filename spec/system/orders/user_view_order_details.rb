require 'rails_helper'

describe 'Usuáro vê detalhes de pedido' do
  it 'a partir do menu' do
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
    order = Order.create!(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                          estimated_delivery_date: "#{Date.today+1}", user_id: user.id, 
                          order_code:code)

    # Act
    visit root_path
    login_as(user)
    click_on 'Ver pedidos'
    click_on code
   
    # Assert
    expect(page).to have_content(warehouse.full_description)
    expect(page).to have_content(supplier.corporate_name)
    expect(page).to have_content(user.description)
    expect(page).to have_content(I18n.localize(order.estimated_delivery_date))
  end
  it 'e volta para a tela de pedidos' do
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
    order = Order.create!(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                          estimated_delivery_date: "#{Date.today+5}", user_id: user.id, 
                          order_code:code)

    # Act
    visit root_path
    login_as(user)
    click_on 'Ver pedidos'
    click_on code
    click_on "Galpões & Estoque"
   
    # Assert
    expect(page).to have_content("Fornecedores")
    expect(page).to have_content("Modelos de Produtos")
    expect(page).to have_content("Registrar pedido")
    expect(page).to have_content("Ver pedidos")
    expect(page).to have_content("luciana - luciana@gmail.com")
  end
end