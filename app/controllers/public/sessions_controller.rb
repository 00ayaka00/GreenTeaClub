# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :configure_sign_in_params, only: [:create]
  def after_sign_in_path_for(resource)
    #byebug
    about_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
 def create
  self.resource = warden.authenticate(auth_options) # Deviseの認証を使用

  if resource.present?
    set_flash_message!(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  else
    @user = User.new(sign_in_params) # 新しいユーザーオブジェクトを作成
    @user.errors.add(:base, 'メールアドレスまたはパスワードが正しくありません。') # エラーメッセージを追加
    flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
    render :new
  end
end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
