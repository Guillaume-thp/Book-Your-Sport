# frozen_string_literal: true

class User < ApplicationRecord
  has_many :charges
  after_create :welcome_send
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  end
end
