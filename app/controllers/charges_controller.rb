class ChargesController < ApplicationController
  def new
  end
  
  def create
    # Amount in cents
    @price = params[:price]*100
    
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
      customer: customer.id,
      price: @price,
      description: 'Rails Stripe customer',
      currency: '€',
    })
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
