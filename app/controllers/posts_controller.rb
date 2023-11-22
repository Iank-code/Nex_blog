class PostsController < ApplicationController
    before_action only:[:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end
    def show
        @post = Post.find(params[:id])
        @post
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)

        # if @post.save
        #     redirect_to @post, notice: "Post was successfully created"

        # else
        #     render :new
        # end
        respond_to do |format|
            if @post.save
                format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
                format.json { render :show, status: :created, location: @post }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
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
