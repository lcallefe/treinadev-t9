class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :state, 
            :full_address, :city, :email, presence: true
end
