# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      user = User.new(account_register_params)
      user.save
      sign_in_and_redirect user, event: :authentication
    end

    # 更新使用者資訊
    # resource= User, params = 要更新的參數
    def update_resource(resource, _params)
      resource.update(account_update_params)
    end

    private

    # 取得使用者資料允許更新的參數
    def account_update_params
      params.require(:user).permit(:email, :name, :city, :tel, :avatar, :avatar_url)
    end

    def account_register_params
      params.require(:user).permit(:email, :name, :city, :tel, :avatar, :avatar_url, :password)
    end
  end
end
