module Api
  module V1
    class MerchantsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_merchant, only: [:show, :update, :destroy]
      before_action :set_firebase, only: [:create, :update, :destroy]

      # GET /merchants
      def index
        @merchants = Merchant.all

        render json: @merchants
      end

      # GET /search_merchants
      def search_merchants
        if !params[:search].nil?
          @merchants = Merchant.search(params[:search].order("name ASC"))
        else
          @merchants = Merchant.all.order("name ASC")
        end

        render json: @merchants
      end

      # GET /merchants/1
      def show
        render json: @merchant
      end

      # POST /merchants
      def create
        @merchant = Merchant.new(merchant_params)

        if @merchant.save
          @firebase.push("merchants/#{@merchant.id}", @merchant)
          render json: @merchant, status: :created
        else
          render json: @merchant.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /merchants/1
      def update
        if @merchant.update(merchant_params)
          @firebase.update("merchants", { "#{@merchant.id}": @merchant })
          render json: @merchant
        else
          render json: @merchant.errors, status: :unprocessable_entity
        end
      end

      # DELETE /merchants/1
      def destroy
        @firebase.delete("merchants/#{@merchant.id}", {})

        @merchant.destroy
      end

      private
      
      def set_merchant
        @merchant = Merchant.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def merchant_params
        params.require(:merchant).permit(:name, :description, :address, :phone, :postal_code, :category, :user_id)
      end

      def set_firebase
        @firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
      end
    end
  end
end
