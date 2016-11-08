class UserNotifier < ApplicationMailer
  def send_link(current_user, recipient, link)
    @user = current_user
    @recipient = recipient
    @link = link
    mail(to: @recipient,
    subject: "#{@user.email_address} sent you a link!")
  end
end
