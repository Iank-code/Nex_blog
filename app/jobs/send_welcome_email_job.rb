class SendWelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    UserMailer.with(user: user).welcome_email(user.email).deliver_now
  end
end
