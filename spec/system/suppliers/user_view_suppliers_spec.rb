require 'rails_helper'

describe 'Usuáro vê fornecedores' do
  it 'a partir da tela principal' do
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
        
    # Assert
    expect(page).to have_content('ACME')
    expect(page).to have_content('Bauru - SP')
  end
  it 'e volta para a tela inicial' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    s = Supplier.create!(corporate_name: 'CARGILL Alimentos', brand_name: 'CARGILL', 
    registration_number: '7152226000118', state: 'AM', 
    full_address: 'Avenida Amazonas, 123', city: 'Manaus',
    email: 'contato@cargill.com.br')

    # Act
    visit root_path
    login_as(user)
    click_on 'Fornecedores'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(root_path)
  end
end