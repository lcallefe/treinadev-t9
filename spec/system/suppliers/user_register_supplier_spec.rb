require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela de fornecedores' do
    # Arrange


    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'

    # Assert
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Marca')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('E-mail')
  end

  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: 'Perdigão S.A'
    fill_in 'Marca', with: 'Perdigão'
    fill_in 'Endereço', with: 'Avenida José Martins da Costa, 134'
    fill_in 'Cidade', with: 'Embu das Artes'
    fill_in 'Estado', with: 'SP'
    fill_in 'CNPJ', with: '01.838.723.0098.50'
    fill_in 'E-mail', with: 'perdigão@perdigão.com'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Perdigão'
    expect(page).to have_content 'Embu das Artes - SP'
  end

  it 'com dados incompletos' do
    # Arrange

    # Act
    
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Marca não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end 



end