require 'rails_helper'

describe 'Usuáro vê detalhes de pedido' do
  it 'a partir do menu' do
     
    user = User.create!(email: 'luciana@gmail.com', password: 'password', name: 'luciana')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '6778075000107', state: 'SP', 
                                full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                email: 'contato@acme.com.br')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                  area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                  cep: '15000-000', description: 'Galpão destinado para cargas 
                                  internacionais')
 
    order = Order.create!(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                          estimated_delivery_date: 1.day.from_now, user_id: user.id)

    
    visit root_path
    login_as(user)
    click_on 'Ver pedidos'
    click_on order.order_code
   
    
    expect(page).to have_content(warehouse.full_description)
    expect(page).to have_content(supplier.corporate_name)
    expect(page).to have_content(user.description)
    expect(page).to have_content(I18n.localize(order.estimated_delivery_date))
  end
  it 'e volta para a tela de pedidos' do
        
    user = User.create!(email: 'luciana@gmail.com', password: 'password', name: 'luciana')
    supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                                registration_number: '6778075000107', state: 'SP', 
                                full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                                email: 'contato@acme.com.br')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                  area: 100_000, address: 'Avenida do Aeroporto, 100', 
                                  cep: '15000-000', description: 'Galpão destinado para cargas 
                                  internacionais')
 
    order = Order.create!(warehouse_id: warehouse.id, supplier_id: supplier.id, 
                          estimated_delivery_date: 5.days.from_now, user_id: user.id)

    visit root_path
    login_as(user)
    click_on 'Ver pedidos'
    click_on order.order_code
    click_on "Galpões & Estoque"
   
    expect(page).to have_content("Fornecedores")
    expect(page).to have_content("Modelos de Produtos")
    expect(page).to have_content("Registrar pedido")
    expect(page).to have_content("Ver pedidos")
    expect(page).to have_content("luciana - luciana@gmail.com")
  end
end