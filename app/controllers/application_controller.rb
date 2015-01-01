class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: 'vahed', password: 'acmvahedacm'

  before_action :authenticate_user!
  before_action :set_profile


  helper_method :persian_num
  def persian_num(num)
    persianNums={1=>"۱",2=>"۲",3=>"۳",4=>"۴",5=>"۵",6=>"۶",7=>"۷",8=>"۸",9=>"۹",0=>"۰"}
    s=""
    while num>=1
      s=persianNums[num%10]+s
      num=num/10
    end
    return s
  end

  def set_profile
    if current_user and !current_user.profile
      redirect_to new_profile_path
    end
  end

end
