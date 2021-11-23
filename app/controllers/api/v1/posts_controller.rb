class Api::V1::PostsController < ApplicationController
    skip_before_action :process_token, only: [:index]

    # GET: v1/posts
    def index
        posts = Post.all
        render json: posts, status: :ok
    end

    # POST: v1/
    def new
        
    end
end
