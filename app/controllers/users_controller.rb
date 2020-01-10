class UsersController < ApplicationController
    before_action :authorize!# トークンはこれ書けばいける
    before_action :set_user, only:[:update, :destroy, :timeline]

    def index # ユーザー一覧
        users = User.all.order(updated_at: :desc)
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
        users,
        serializer: UserSerializer,
    )
    render json: serializer.as_json
    end

    def update # ユーザー編集
        @user.update!(user_params)
        serializer = MeSerializer.new(@user)
        render json: serializer.as_json
    end

    def destroy # ユーザー削除
        @user.destroy!
        render json: {'message': '正常にUser削除されました'}
    end

    def show
        serializer = UserSerializer.new(@user, current_user: current_user)
        render json: serializer.as_json
    end

    def timeline
        logger.debug('aaaaaaaaaaa')
        logger.debug(@user.inspect)
        logger.debug('aeee')
        user_posts = @user.posts
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
        user_posts,
        serializer: PostSerializer,
    )
    render json: serializer.as_json
    end

    def user_params
        params.require(:user_params).permit(
            :name,
            :bio
        )
    end

    def set_user
        @user = User.where(id: params[:id]).first
    end
end
