require 'rails_helper'
RSpec.describe 'Payment Management' do
  describe 'get /charges' do


    context 'there are transactions on the history' do
      let(:customer_1) { create :customer }
      let(:customer_2) { create :customer }
      let(:customer_3) { create :customer }
      let!(:success_payment) { create :payment, customer_id: customer_1.id, paid: true, refunded: false }
      let!(:failed_payment) { create :payment, customer_id: customer_2.id, paid: false, refunded: false }
      let!(:disputed_payment) { create :payment, customer_id: customer_3.id, refunded: true, paid: true }
      it 'renders template charges/index' do
        get '/charges'
        expect(response).to render_template('index')
      end
      it 'shows list of successful charges' do
        get '/charges'
        expect(assigns(:charge_list).key?(:successful_charges)).to be_truthy
        expect(assigns(:charge_list)[:successful_charges]).to include(success_payment)
      end
      it 'shows list of failed charges' do
        get '/charges'
        expect(assigns(:charge_list).key?(:failed_charges)).to be_truthy
        expect(assigns(:charge_list)[:failed_charges]).to include(failed_payment)
      end
      it 'shows list of disputed_charges charges' do
        get '/charges'
        expect(assigns(:charge_list).key?(:disputed_charges)).to be_truthy
        expect(assigns(:charge_list)[:disputed_charges]).to include(disputed_payment)
      end
    end
    context 'there are no transactions on the history' do
      let(:customer_1) { create :customer }
      let(:customer_2) { create :customer }
      let(:customer_3) { create :customer }
      it 'renders template charges/index' do
        get '/charges'
        expect(response).to render_template('index')

      end
      it 'shows no transactions' do
        get '/charges'
        expect(assigns(:charge_list).key?(:successful_charges)).to be_truthy
        expect(assigns(:charge_list).key?(:failed_charges)).to be_truthy
        expect(assigns(:charge_list).key?(:disputed_charges)).to be_truthy
        expect(assigns(:charge_list)[:failed_charges]).to be_empty
        expect(assigns(:charge_list)[:successful_charges]).to be_empty
        expect(assigns(:charge_list)[:disputed_charges]).to be_empty
      end
    end
  end
end
