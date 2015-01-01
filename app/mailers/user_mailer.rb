class UserMailer < ActionMailer::Base
  
  # class variable to hold logo
  @@acm = File.read(Rails.root.join('app', 'assets', 'images', 'acm-logo.png'))
  
  # setting default from
  default from: "ACM Student Chapter"

  # call this method to send an email
  def welcome(user)
    recipient = user.email
    subject =
        'به شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران خوش آمدید'
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'welcome_message' }
#      format.html { render 'welcome_message' }
    end
  end
  def start_register(profile, event)
    recipient = profile.user.email
    subject =
    'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
        'آغاز ثبت نام رویداد ' + event.title
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'start_register', :locals => {:profile => profile, :event => event} }
#      format.html { render 'welcome_message' }
    end
  end
  def complete_payment(payment)
    recipient = payment.profile.user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
            'پرداخت '
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'user_mailer/complete_payment', :locals => {:profile => payment.profile, :amount => payment.amount} }
#      format.html { render 'welcome_message' }
    end
  end
  def complete_invoice(invoice)
    recipient = invoice.participation.profile.user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
'صورت‌حساب ثبت‌نام رویداد ' +
            invoice.participation.event.title
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'user_mailer/complete_invoice', :locals => {:profile => invoice.participation.profile, :event => invoice.participation.event} }
#      format.html { render 'welcome_message' }
    end
  end

  def book_event(participation)
    recipient = participation.profile.user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
            'رویداد '+
            participation.event.title
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'user_mailer/book_event', :locals => {:profile => participation.profile, :event => participation.event} }
#      format.html { render 'welcome_message' }
    end
  end

  def send_all_register(profile)
    recipient = profile.user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
            'راه‌اندازی پرداخت الکترونیکی و ثبت‌نام رویدادها'

    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'user_mailer/send_all_register', :locals => {:profile => profile} }
#      format.html { render 'welcome_message' }
    end
  end



end
