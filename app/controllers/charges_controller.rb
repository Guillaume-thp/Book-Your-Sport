# frozen_string_literal: true

class ChargesController < ApplicationController
  def new 
    
  end

  def create
    # Amount in cents
    @date = params[:date]
    @hour = params[:hour]
    @duration = params[:duration]
    @amount = params[:amount]

    if booking.save
      redirect_to 

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
