module Api
  module V1
    class AdvertisementsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_advertisement, only: [:show, :update, :destroy]
      before_action :set_firebase, only: [:create, :update, :destroy]

      # GET /merchants or /merchants/:merchant_id/advertisements
      def index
        @advertisements = Advertisement.where(merchant_id: params[:merchant_id])

        render json: @advertisements
      end

      # POST /advertisements
      def create
        @advertisement = Advertisement.new(advertisement_params)

        if @advertisement.save
          @firebase.push("advertisements/#{@advertisement.id}", @advertisement)
          render json: @advertisement, status: :created
        else
          render json: @advertisement.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /advertisements/1
      def update
        if @advertisement.update(advertisement_params)
          @firebase.update("advertisements", { "#{@advertisement.id}": @advertisement })
          render json: @advertisement
        else
          render json: @advertisement.errors, status: :unprocessable_entity
        end
      end

      # DELETE /advertisements/1
      def destroy
        @firebase.delete("advertisements/#{@advertisement.id}", {})
        @advertisement.destroy
      end

      private

      def set_advertisement
        @advertisement = Advertisement.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def advertisement_params
        params.require(:advertisement).permit(:title, :category, :dollar_value, :expiary_date, :merchant_id)
      end

      def set_firebase
        @firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
      end
    end
  end
end
