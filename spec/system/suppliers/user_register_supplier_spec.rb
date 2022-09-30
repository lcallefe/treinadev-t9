require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela de fornecedores' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')


    # Act
    visit root_path
    login_as(user)
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'

    # Assert
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('E-mail')
  end

  it 'com sucesso' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')

    # Act
    visit root_path
    login_as(user)
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: 'Perdigão'                      
    fill_in 'Razão Social', with: 'Perdigão S.A'
    fill_in 'Endereço', with: 'Avenida José Martins da Costa, 134'
    fill_in 'Cidade', with: 'Embu das Artes'
    fill_in 'Estado', with: 'SP'
    fill_in 'CNPJ', with: '1687481000171'
    fill_in 'E-mail', with: 'perdigão@perdigão.com'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Perdigão'
    expect(page).to have_content 'Embu das Artes - SP'
  end

  it 'com dados incompletos' do
    # Arrange 
    user = User.create!(email: 'luciana@gmail.com', password: 'password')

    # Act
    
    visit root_path
    login_as(user)
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end 



end