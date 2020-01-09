class SignInsController < ApplicationController
    
    def create
        user = User.find_by(email: params[:sign_in_user_params][:email])
        if user.blank?
            raise ActiveRecord::RecordNotFound.new("そのemailはありません") and return
        end# ActiveRecord::RecordNotFound（見つからなかった時）はエラーメッセージのこと
        if user.authenticate(params[:sign_in_user_params][:password])
            serializer = SignUpSerializer.new(user)# 新しくSignUpSerializerを作ってこのユーザーですって
# 感じにしてる#
            render json: serializer.as_json
        else
            raise ActionController::BadRequest.new("そのemailもしくはpasswordが違います")
        end# ActiveRecord::BadRequest（不正アクセス）はエラーメッセージのこと
    end

    def sign_in_user_params
        params.require(:sign_in_user_params).permit(
            :email,
            :password,
            :password_confirmation
        )
    end
end