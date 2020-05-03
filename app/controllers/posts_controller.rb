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
          flash.notice = "Post, '#{@post.title}' created!"
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
      flash.notice = "Post, '#{@post.title}' updated!"
      redirect_to @post
    else
        render :edit
    end
    end

    def destroy
        @post = current_user.posts.find(params[:id])
        @post.destroy
        flash.notice = "Post, '#{@post.title}' deleted!"
        redirect_to root_path
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def find_post
        @post = Post.find(params[:id])
    end

    def delete_authorization
         if !current_user.posts.find_by_id(params[:id])
            flash.alert = "Post, cant be deleted!, authorize author only"
            redirect_to :root
         end
      end

end
