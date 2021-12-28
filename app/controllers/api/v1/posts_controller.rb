class Api::V1::PostsController < ApplicationController
    skip_before_action :process_token, only: [:index]

    # GET: v1/posts
    def index
        posts = Post.all
        render json: posts, status: :ok
    end

    # POST: v1/
    def new
        post = Post.new(post_params)
        post.user_id = @current_user_id
        post.save
        render json: HttpResponse.new.success(message: "Post created successfully!"), status: :ok
    end

    def post_params
        params.require(:post).permit(:title, :description, :short_description, :image_url)
    end
end
