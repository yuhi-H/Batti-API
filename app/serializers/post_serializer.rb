class PostSerializer < ActiveModel::Serializer
    attributes :id,
                :content,
                :user,
                :created_at,
                :updated_at

    def user
        user = User.where(id: object.user_id).first
        current_user = instance_options[:current_user]
        UserSerializer.new(user, current_user: current_user)
    end
end
