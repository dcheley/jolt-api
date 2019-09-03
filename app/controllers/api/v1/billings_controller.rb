module Api
  module V1
    class BillingsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_billing, only: [:show, :update, :destroy]
      before_action :set_firebase, only: [:create, :update, :destroy]

      # GET /merchants/:merchant_id/billings
      def index
        @billings = Billing.where(merchant_id: params[:merchant_id])

        render json: @billings
      end

      # POST /merchants/:merchant_id/billings
      def create
        @billing = Billing.new(billing_params)

        if @billing.save
          @firebase.push("billings/#{@billing.id}", @billing)
          render json: @billing, status: :created
        else
          render json: @billing.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /merchants/:merchant_id/billings/1
      def update
        if @billing.update(billing_params)
          @firebase.update("billings", { "#{@billing.id}": @billing })
          render json: @billing
        else
          render json: @billing.errors, status: :unprocessable_entity
        end
      end

      # DELETE /merchants/:merchant_id/billings/1
      def destroy
        @firebase.delete("billings/#{@billing.id}", {})
        @billing.destroy
      end

      private

      def set_billing
        @billing = Billing.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      # TODO: Remove columns and redo forms later when we use Stripe/w.e
      def billing_params
        params.require(:billing).permit(:first_name, :last_name, :institution,
          :address, :city, :postal_code, :province, :phone, :merchant_id, :credit_card_number,
          :credit_expiary_date, :cvv)
      end

      def set_firebase
        @firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
      end
    end
  end
end
