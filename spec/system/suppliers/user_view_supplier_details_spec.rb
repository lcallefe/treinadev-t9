require 'rails_helper'

describe 'Usuáro vê detalhes de um fornecedor' do
  it 'a partir do menu' do
    # Arrange
    s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                         registration_number: '456789', state: 'SP',
                         full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                         email: 'contato@acme.com.br')
                        
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    # Assert
    expect(page).to have_content('456789')
    expect(page).to have_content('Avenida do Aeroporto, 1000 - Bauru - SP')
    expect(page).to have_content('E-mail:')
    expect(page).to have_content('contato@acme.com.br')
  end
  it 'e volta para a tela de fornecedores' do
    # Arrange
      s = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', 
                           registration_number: '456789', state: 'SP',
                           full_address: 'Avenida do Aeroporto, 1000', city: 'Bauru',
                           email: 'contato@acme.com.br')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(suppliers_path)
  end
end