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
  def send_report(admin, report)
    recipient = admin.email
    subject =
    'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
        "ثبت گزارش"
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'send_report', :locals => {:report => report} }
#      format.html { render 'welcome_message' }
    end
  end
  def send_modification_units(user, unit_ids)
    recipient = user.email
    subject =
        'شاخه‌ی دانشجویی ای‌سی‌ام دانشگاه تهران -' +
            "تغییر در واحد‌ها"
    attachments.inline['acm.png'] = @@acm

    puts 'Email: to => ' + recipient + ', subject => ' + subject
    mail(to: recipient, subject: subject) do |format|
      format.html { render 'send_modification_units', :locals => {:unit_ids => unit_ids} }
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
