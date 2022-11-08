require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e vê o nome da app' do
    # Arrange
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    # Act
    login_as(user)
    visit root_path
    
    # Assert
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link('Galpões & Estoque', href: root_path)
  end

  it 'e vê os galpões cadastrados' do
    # Arrange
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do Porto, 1000', 
                     cep: '20000-000' , description: 'Galpão do Rio')
    Warehouse.create(name: 'Maceio', code: 'MCZ' , city: 'Maceio', area: 50_000, address: 'Av Brasil, 2000', 
                     cep: '35000-000', description: 'Galpão de Recife')

    # Act
    login_as(user)
    visit root_path
    

    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    # Act
    login_as(user)
    visit root_path
    
    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end

end