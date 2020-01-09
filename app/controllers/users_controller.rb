class UsersController < ApplicationController
    before_action :authorize!

    def index
        users = User.all.order(updated_at: :desc)
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
        users,
        serializer: UserSerializer,
    )
    render json: serializer.as_json
    end
end
