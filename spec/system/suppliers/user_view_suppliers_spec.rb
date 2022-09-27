require 'rails_helper'

describe 'Usuáro vê fornecedores' do
  it 'a partir da tela principal' do
    # Arrange
    s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                         registration_number: '456789', state: 'SP', 
                         full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                         email: 'contato@acme.com.br')
                        
    # Act
    visit root_path
    click_on 'Fornecedores'
        
    # Assert
    expect(page).to have_content('ACME')
    expect(page).to have_content('Bauru - SP')
  end
  it 'e volta para a tela inicial' do
    # Arrange
    s = Supplier.create!(corporate_name: 'CARGILL Alimentos', brand_name: 'CARGILL', 
    registration_number: '234123', state: 'AM', 
    full_address: 'Avenida Amazonas, 123', city: 'Manaus',
    email: 'contato@cargill.com.br')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(root_path)
  end
end