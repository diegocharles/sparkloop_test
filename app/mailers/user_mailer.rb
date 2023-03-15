class UserMailer < ApplicationMailer

  def deletion_notice(first_name, email)
    @first_name = first_name
    mail(to: email, subject: "Your account has been deleted")
  end
end
