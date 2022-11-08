require 'rails_helper'

describe 'Usuáro vê detalhes de um fornecedor' do
  it 'a partir do menu' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                         registration_number: '6778075000107', state: 'SP',
                         full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                         email: 'contato@acme.com.br')
                        
    # Act
    visit root_path
    login_as(user)
    click_on 'Fornecedores'
    click_on 'ACME'
    # Assert
    expect(page).to have_content('6778075000107')
    expect(page).to have_content('Avenida do Aeroporto, 1000 - Bauru - SP')
    expect(page).to have_content('E-mail:')
    expect(page).to have_content('contato@acme.com.br')
  end
  it 'e volta para a tela de fornecedores' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                         registration_number: '6778075000107', state: 'SP',
                         full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                         email: 'contato@acme.com.br')

    # Act
    visit root_path
    login_as(user)
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(suppliers_path)
  end
end