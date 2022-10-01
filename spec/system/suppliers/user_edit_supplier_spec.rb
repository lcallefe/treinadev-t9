require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                         registration_number: '6778075000107', state: 'SP', 
                         full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                         email: 'contato@acme.com.br')
    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    # Assert
    expect(page).to have_field('Razão Social',  with: 'ACME LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'ACME')
    expect(page).to have_field('CNPJ', with: '6778075000107')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1000')
    expect(page).to have_field('Cidade', with: 'Bauru')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('E-mail', with: 'contato@acme.com.br')
  end
  it 'com sucesso' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    s = Supplier.create!(corporate_name: 'ACME', brand_name: 'Acme Market', 
                         registration_number: '6778075000107', state: 'SP', 
                         full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                         email: 'contato@acme.com.br')

    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'Acme Market'
    click_on 'Editar'
    fill_in 'Razão Social', with: 'ACME'
    fill_in 'Nome Fantasia', with: 'Acme Market'
    fill_in 'CNPJ', with: '1234567891234'
    fill_in 'E-mail', with: 'contato@acmemarket.com'
    click_on 'Enviar'
    
    # Assert
    expect(page).to have_content 'Fornecedor Acme Market'
    expect(page).to have_content 'CNPJ:'
    expect(page).to have_content '1234567891234' 
    expect(page).to have_content 'Endereço:'
    expect(page).to have_content 'Avenida do Aeroporto, 1000 - Bauru - SP'
    expect(page).to have_content 'E-mail:'
    expect(page).to have_content 'contato@acmemarket.com'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                         registration_number: '6778075000107', state: 'SP', 
                         full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                         email: 'contato@acme.com.br')

    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'
    
    # Assert
    expect(page).to have_content ''
    expect(page).to have_content ''
    expect(page).to have_content ''
    expect(page).to have_content ''                              
  end
end