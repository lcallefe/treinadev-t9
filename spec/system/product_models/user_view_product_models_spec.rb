require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'a partir do menu' do
    # Arrange


    # Act
    visit root_path 
    within('nav') do
      click_on 'Modelos de Produtos'
    end


    # Assert
    expect(current_path).to eq product_models_path

  end
  it 'com sucesso' do

    # Arrange
    supplier = Supplier.create!(brand_name:'Samsung', corporate_name: 'Samsung Eletrônicos',
                                registration_number:'2345678901234', full_address: 'Av Nacoes Unidas, 1000',
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                          sku: 'TV32-XFH', supplier:supplier)
    ProductModel.create!(name: 'TV 42', weight: 9000, width: 80, height: 55, depth: 10,
                          sku: 'TV42-XFG', supplier:supplier)

    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Samsung Eletrônicos'
    expect(page).to have_content 'TV 42'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV42-XFG'
    expect(page).to have_content 'TV32-XFH'
  end

  it 'e não existem produtos cadastrados' do
    # Arrange

    # Act
    visit root_path
    click_on 'Modelos de Produtos'

    # Assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado'

  end

end