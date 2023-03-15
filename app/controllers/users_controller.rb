class UsersController < ApplicationController
  include Pagy::Backend

  before_action :set_user, only: %i[ show edit update destroy ]

  caches_action :index, layout: false

  # GET /users or /users.json
  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true))
  end

  # GET /users/1 or /users/1.json
  def show
    render partial: 'show', locals: { user: @user }, layout: false
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        expire_action action: :index

        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        expire_action action: :index

        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # DELETE /users/bulk_destroy
  def bulk_destroy
    User.where(id: params[:user_ids]).each &:destroy

    expire_action action: :index

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Users were successfully destroyed.", status: 303 }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.fetch(:user, {})
    end
end
