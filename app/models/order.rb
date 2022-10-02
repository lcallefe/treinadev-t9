require 'date'
class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user
  validates :warehouse_id, :supplier_id, presence: true
  validates :order_code, format: { with: /\A[0-9a-zA-Z]{20}\z/}
  validate :estimated_delivery_date_after_today
  validate :estimated_delivery_date_format

  def estimated_delivery_date_after_today
    return if estimated_delivery_date.blank? 

    if estimated_delivery_date < Date.today
      errors.add(:estimated_delivery_date, "deve ser uma data futura.")
    end
  end

  def estimated_delivery_date_format
    if Date.parse(estimated_delivery_date).is_a?()
      errors.add(:estimated_delivery_date, "deve ser preenchida e estar no formato dd/mm/yyyy.")
    end
  end

  def estimated_delivery_date_format
    begin
      Date.parse(estimated_delivery_date.to_s)
    rescue => ex
      errors.add(:estimated_delivery_date, "deve ser preenchida e estar no formato dd/mm/yyyy.")
    end
  end






end
