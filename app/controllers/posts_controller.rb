class PostsController < ApplicationController
    # before_action only:[:index, :show, :edit, :update, :destroy]
    # before_action :authenticate_user, except: [:index, :show]

    def index
        @posts = Post.all.reverse
    end

    def show
        @post = Post.find(params[:id])
        @user = User.find(@post.user_id)
        @post
    end

    def new
        @post = Post.new
    end

    def create
        @user = session[:user_id]
        @post = Post.new(title: params[:title], content: params[:content], user_id: @user)
        respond_to do | format |
            if @post.save
                puts @post
                format.html { redirect_to post_path notice: 'Post was successfully created.'}  
            else
                format.html { render :new, status: :unprocessable_entity}
            end
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        respond_to do |format|
            format.html { redirect_to root_path, notice: 'Post was successfully destroyed.'}
        end
    end

    
    private
    
    def set_post
        @post = Post.find(params[:id])
    end
    def post_params
        params.require(:post).permit(:title, :content)
    end
end
