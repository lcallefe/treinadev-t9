# require 'rails_helper'

# describe 'Usuário se autentica' do
#   it 'com sucesso' do
#     # Arrange

#     # Act
#     visit root_path
#     within('form') do
#       fill_in 'E-mail', with: 'lucianacallefe95@gmail.com'
#       fill_in 'Senha', with: '123abacate'
#       click_on 'Entrar'
#     end

#     # Assert
#       expect(page).to have_content 'Login efetuado com sucesso.'
#       expect(page).not_to have_button 'Entrar'
#       expect(page).to have_button 'Sair'
#       expect(page).to have_content 'luciana - lucianacallefe953@gmail.com'
#   end
#   it 'e faz logout' do
#     # Arrange

#     # Act
#     visit root_path
#     within('form') do
#       fill_in 'E-mail', with: 'lucianacallefe953@gmail.com'
#       fill_in 'Senha', with: '123abacate'
#       click_on 'Entrar'
#     end
#     click_on 'Sair'
#     # Assert
#     expect(page).to have_content 'Logout efetuado com sucesso.'
#     expect(page).to have_button 'Entrar'
#     expect(page).not_to have_button 'Sair'
#     expect(page).not_to have_content 'luciana - lucianacallefe953@gmail.com'

#   end
# end