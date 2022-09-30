require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'luciana@gmail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    # Assert
      expect(page).to have_content 'Login efetuado com sucesso.'
      expect(page).not_to have_button 'Entrar'
      expect(page).to have_button'Sair'
      expect(page).to have_content 'luciana@gmail.com'
  end
  it 'e faz logout' do
    # Arrange
    user = User.create!(email: 'luciana@gmail.com', password: 'password')
    # Act
    visit root_path
    login_as(user)
    click_on 'Entrar'
    fill_in 'E-mail', with: 'luciana@gmail.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'
    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_button 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'luciana@gmail.com'

  end
end