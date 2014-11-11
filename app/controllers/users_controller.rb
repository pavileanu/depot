class UsersController < ApplicationController
  include PhotoSend
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:new, :create]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(name: user_params[:name], password: user_params[:password],
     password_confirmation: user_params[:password_confirmation])

    image = Image.new(uploaded_picture: user_params[:uploaded_picture])

    respond_to do |format|
      if image.save && @user.save
       @user.image = image   
       @user.save
       format.html { redirect_to users_url,
        notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      image = @user.image
      
      if image
        image.uploaded_picture = user_params[:uploaded_picture]  #image to update
      else
        image = Image.new(uploaded_picture: user_params[:uploaded_picture]) #image to create
        @user.image = image
      end
      
      if image.save
       
        if @user.update(name: user_params[:name], password: user_params[:password],
          password_confirmation: user_params[:password_confirmation])
        format.html { redirect_to users_url,
          notice: "User #{@user.name} was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def picture
      #@image = Image.where(user_id: params[:id]).first
      @image = Image.find(params[:id])
      send_data(@image.data,
        filename: @image.name,
        type: @image.type1,
        disposition: "inline")
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :uploaded_picture)
    end
  end
