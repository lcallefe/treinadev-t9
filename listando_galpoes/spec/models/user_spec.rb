require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      # Arrange
      u = User.new(name: 'Julia', email: 'julia@gmail.com')
      # Act
      result = u.description()
      # Assert
      expect(result).to eq('Julia - julia@gmail.com')
    end

  end
end
