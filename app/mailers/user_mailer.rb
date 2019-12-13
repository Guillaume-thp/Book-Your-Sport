# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'bookyoursport@yahoo.com'

  def welcome_email(user)
    @user = user

    @url = 'http://www.bookyoursport.fr/users/sign_in'

    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end
end
