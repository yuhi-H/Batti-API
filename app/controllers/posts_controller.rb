class PostsController < ApplicationController
    before_action :authorize!
    before_action :set_post, only:[:update]

    def create
        post = Post.new(post_params)
        post.user_id = current_user.id
        post.save!
        serializer = PostSerializer.new(post, current_user: current_user)
        render json: serializer.as_json
    end

    def update
        @post.update!(post_params)
        serializer = PostSerializer.new(@post, current_user: current_user)
        render json: serializer.as_json
    end

    def index
        posts = Post.all.order(updated_at: :desc)
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
        posts,
        serializer: PostSerializer,
    )
    render json: serializer.as_json
    end

    def destroy
        @post.destroy!
        render json: {'message': '正常にPost削除されました'}
    end

    def post_params
        params.require(:post_params).permit(
            :content
        )
    end

    def set_post
        @post = Post.where(id: params[:id]).first
    end
end
