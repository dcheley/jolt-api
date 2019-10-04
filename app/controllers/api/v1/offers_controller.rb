module Api
  module V1
    class OffersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_offer, only: [:show, :update, :destroy]
      before_action :set_firebase, only: [:create, :update, :destroy]

      # GET /offers or /merchants/:merchant_id/offers
      def index
        if !params[:merchant_id]
          @offers = Offer.all
        else
          @offers = Offer.where(merchant_id: params[:merchant_id])
        end

        render json: @offers
      end

      # POST /offers
      def create
        @offer = Offer.new(offer_params)

        if @offer.save
          @firebase.push("offers/#{@offer.id}", @offer)
          render json: @offer, status: :created
        else
          render json: @offer.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /offers/1
      def update
        if @offer.update(offer_params)
          @firebase.update("offers", { "#{@offer.id}": @offer })
          render json: @offer
        else
          render json: @offer.errors, status: :unprocessable_entity
        end
      end

      # DELETE /offers/1
      def destroy
        @firebase.delete("offers/#{@offer.id}", {})
        @offer.destroy
      end

      private

      def set_offer
        @offer = Offer.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def offer_params
        params.require(:offer).permit(:title, :category, :dollar_value, :expiry_date, :merchant_id)
      end

      def set_firebase
        @firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
      end
    end
  end
end
