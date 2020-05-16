class Payment < ActiveRecord::Base
  belongs_to :customer
  scope :disputed, -> { where(refunded: true, paid: true) }
  scope :successful, -> { where(refunded: false, paid: true) }
  scope :failed, -> { where(refunded: false, paid: false) }

  def date_created
    Time.zone.at(created).to_datetime.strftime('%c')
  end

end
