require "rails_helper"

RSpec.describe UserNotifier, type: :mailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @user = User.create(email_address: 'david@example.com', password: 'password')
    @recipient = 'recipient@example.com'
    @link = 'https://www.example.com'
    UserNotifier.send_link(@user, @recipient, @link).deliver_now
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it 'should send an email' do
    ActionMailer::Base.deliveries.count.should == 1
  end

  it 'renders the receiver email' do
    ActionMailer::Base.deliveries.first.to.should == [@recipient]
  end

  it 'should set the subject to the correct subject' do
    ActionMailer::Base.deliveries.first.subject.should == "david@example.com sent you a link!"
  end

  it 'renders the sender email' do
    ActionMailer::Base.deliveries.first.from.should == ["no-reply@link-keeper.com"]
  end
end
