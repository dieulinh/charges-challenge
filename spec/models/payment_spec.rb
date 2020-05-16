require 'rails_helper'
RSpec.describe Payment, type: :model do
  describe '.disputed' do
    let(:customer) { create :customer }
    let!(:payment_1) { create :payment, refunded: false, customer_id: customer }
    let!(:payment_2) { create :payment, refunded: true, paid: true, customer_id: customer }
    let!(:payment_3) { create :payment, refunded: true, paid: true, customer_id: customer}
    let!(:payment_4) { create :payment, refunded: false, customer_id: customer}
    before do

    end
    it 'returns the transaction with all value that has flag refunded' do
      expect(described_class.disputed).to include(payment_2)
      expect(described_class.disputed).to include(payment_3)
    end
    it 'not include success transaction' do
      expect(described_class.disputed).not_to include(payment_1)
      expect(described_class.disputed).not_to include(payment_4)
    end
  end
  describe '.successful' do
    let(:customer) { create :customer }
    let!(:payment_1) { create :payment, refunded: false, paid: true, customer_id: customer }
    let!(:payment_2) { create :payment, refunded: false, paid: true, customer_id: customer }
    let!(:payment_3) { create :payment, refunded: true, paid: false, customer_id: customer}
    let!(:payment_4) { create :payment, refunded: false, paid: false, customer_id: customer}
    before do

    end
    it 'returns the transaction with all value that has flag paid equal true and refunded is false' do
      expect(described_class.successful).to include(payment_1)
      expect(described_class.successful).to include(payment_2)
    end
    it 'not include failed or disputed transaction' do
      expect(described_class.successful).not_to include(payment_3)
      expect(described_class.successful).not_to include(payment_4)
    end
  end
  describe '.failed' do
    let(:customer) { create :customer }
    let!(:payment_1) { create :payment, refunded: false, paid: false, customer_id: customer }
    let!(:payment_2) { create :payment, refunded: true, paid: true, customer_id: customer }
    let!(:payment_3) { create :payment, refunded: true, paid: true, customer_id: customer}
    let!(:payment_4) { create :payment, refunded: false, paid: false, customer_id: customer}
    before do

    end
    it 'returns the transaction with all value that has flag refunded' do
      expect(described_class.failed).to include(payment_1)
      expect(described_class.failed).to include(payment_4)
    end
    it 'not include success transaction' do
      expect(described_class.failed).not_to include(payment_2)
      expect(described_class.failed).not_to include(payment_3)
    end
  end
end
