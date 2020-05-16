class ChargesController < ApplicationController
  def index
    @charge_list = { successful_charges: [], failed_charges: [], disputed_charges: [] }
    @charge_list[:successful_charges] = Payment.successful
    @charge_list[:failed_charges] = Payment.failed
    @charge_list[:disputed_charges] = Payment.disputed
  end
end
