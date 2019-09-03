module Api
  module V1
    class PromotionsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_promotion, only: [:show, :update, :destroy]
      before_action :set_firebase, only: [:create, :update, :destroy]

      # GET /merchants or /merchants/:merchant_id/promotions
      def index
        @promotions = Promotion.where(merchant_id: params[:merchant_id])

        render json: @promotions
      end

      # POST /promotions
      def create
        @promotion = Promotion.new(promotion_params)

        if @promotion.save
          @firebase.push("promotions/#{@promotion.id}", @promotion)
          render json: @promotion, status: :created
        else
          render json: @promotion.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /promotions/1
      def update
        if @promotion.update(promotion_params)
          @firebase.update("promotions", { "#{@promotion.id}": @promotion })
          render json: @promotion
        else
          render json: @promotion.errors, status: :unprocessable_entity
        end
      end

      # DELETE /promotions/1
      def destroy
        @firebase.delete("promotions/#{@promotion.id}", {})
        @promotion.destroy
      end

      private

      def set_promotion
        @promotion = Promotion.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def promotion_params
        params.require(:promotion).permit(:title, :category, :dollar_value, :expiary_date, :merchant_id)
      end

      def set_firebase
        @firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
      end
    end
  end
end
