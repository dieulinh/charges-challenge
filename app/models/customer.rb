class Customer < ApplicationRecord
  has_many :payments
  validates :first_name, presence: true
  validates :last_name, presence: true

  def fullname
    [first_name, ' ', last_name].join(' ')
  end
end
