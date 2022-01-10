class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update] # probably want to keep using this
  before_action :SIGNED_in_user, only: [:index, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # # GET /users/1
  # # GET /users/1.json
  def show
    @user = User.find_by_id(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @comment = Comment.new
  end

  # # PATCH/PUT /users/1
  # # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:role, :user_name)
    end

end
