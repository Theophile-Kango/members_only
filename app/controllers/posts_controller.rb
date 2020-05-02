class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :find_post, only: [:show, :edit, :update]
    before_action :delete_authorization, only: [:destroy]

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.new(post_params)
        if @post.save
            redirect_to root_path
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
    if @post.update(post_params)
        redirect_to @post
    else
        render :edit
    end
    end

    def destroy
        @post = current_user.posts.find(params[:id])
        @post.destroy
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def find_post
        @post = Post.find(params[:id])
    end

    def delete_authorization
        redirect_to :root unless current_user.posts.find_by_id(params[:id])
      end

end
