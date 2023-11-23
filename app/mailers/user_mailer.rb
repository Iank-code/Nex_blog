class UserMailer < ApplicationMailer
    default from: "kian99564@gmail.com"

    def welcome_email(user)
        puts user
        mail(to: user, subject: 'Welcome to My Awesome Site')
    end
end
