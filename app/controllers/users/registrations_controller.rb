# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        flash.now[:alert] = resource.errors.full_messages.map {|el| el.split(" ").last}.join("\n") if resource.errors.any?
      end
    end
    
    # 更新使用者資訊
    # resource= User, params = 要更新的參數
    def update_resource(resource, _params)
      resource.update(account_update_params)
    end

    private

    # 取得使用者資料允許更新的參數
    def account_update_params
      params.require(:user).permit(:email, :name, :city, :tel, :avatar, :omniauth_avatar)
    end

    def sign_up_params
      params.require(:user).permit(:email, :name, :city, :tel, :omniauth_avatar, :password, :password_confirmation)
    end
  end
end
