class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create] 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, flash: { success: 'Registration successfully' }
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  # before_action :session_expired?, only: [:check_login_status]

  # # GET /users or /users.json
  # def index
  #   @users = User.all
  # end

  # # GET /users/1 or /users/1.json
  # def show
  #   @user = User.find(params[:id])
  #   @user
  # end

  # # GET /users/new
  # def new
  #   @user = User.new
  # end

  # # GET /users/1/edit
  # def edit
  # end

  # # POST /users or /users.json
  # def create
  #   @user = User.create(user_params)
  #   @post = Post.all

    
  #   if @user.valid
  #     session[:user_id] = @user.id
  #     format.html { redirect_to posts_url, notice: "User was successfully created." }
  #     format.json { render :show, status: :created, location: @post }
  #   else
  #     format.html { render :new, status: :unprocessable_entity }
  #     format.json { render json: @user.errors, status: :unprocessable_entity }
  #   end
  # end

  # # PATCH/PUT /users/1 or /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /users/1 or /users/1.json
  # def destroy
  #   @user.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_user
  #     @user = User.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def user_params
  #     params.require(:user).permit(:name, :email, :password, :password_confirmation)
  #   end
end
