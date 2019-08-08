module Api
  module V1
    class MerchantsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_merchant, only: [:show, :update, :destroy]

      # GET /merchants
      def index
        @merchants = Merchant.all

        render json: @merchants
      end

      # GET /merchants/1
      def show
        render json: @merchant
      end

      # POST /merchants
      def create
        firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
        @merchant = Merchant.new(merchant_params)

        if @merchant.save
          firebase_response = firebase.push("merchants", @merchant)
          render json: @merchant, status: :created
        else
          render json: @merchant.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /merchants/1
      def update
        # firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)

        if @merchant.update(merchant_params)
          render json: @merchant
        else
          render json: @merchant.errors, status: :unprocessable_entity
        end
      end

      # DELETE /merchants/1
      def destroy
        @merchant.destroy
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_merchant
        @merchant = Merchant.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def merchant_params
        params.require(:merchant).permit(:name, :description, :address, :phone, :postal_code, :category, :user_id)
      end
    end
  end
end
