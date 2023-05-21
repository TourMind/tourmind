# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def after_sign_out_path_for(_resource_or_scope)
      root_path
    end

    def after_sign_in_path_for(_resource_or_scope)
      if current_user.diamond_grade != '一般會員' && membership_expiry_date < format_date(Time.now)
        current_user.update(diamond_grade: '一般會員')
        flash[:alert] = '會員已到期！'
      end
      request.referer || root_path
    end
  end
end
