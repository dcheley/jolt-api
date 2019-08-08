module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /users
      def index
        @users = User.all

        render json: @users
      end

      # GET /users/1
      def show
        render json: @user
      end

      # POST /users
      def create
        firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
        @user = User.new(user_params)

        if @user.save
          firebase_response = firebase.push("users", @user)
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1
      def destroy
        @user.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :phone, :role)
      end
    end
  end
end
