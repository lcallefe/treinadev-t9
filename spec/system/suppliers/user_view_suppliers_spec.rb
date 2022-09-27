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
  # it 'e volta para a tela inicial' do
  #   # Arrange
  #   w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
  #   address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
  #   description: 'Galpão destinado para cargas internacionais')
  #   w.save()

  #   # Act
  #   visit root_path
  #   click_on 'Aeroporto SP'
  #   click_on 'Voltar'

  #   # Assert
  #   expect(current_path).to eq(root_path)
    
end