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
        # @merchant = Merchant.find(params[:merchant_id])
        Stripe.api_key = Rails.application.credentials.stripe_secret_key

        begin
          puts "stripee"
          customer = Stripe::PaymentMethod.create(
            type: "card",
            card: {
              number: params[:credit_card_number],
              exp_moth: params[:credit_expiry_date],
              cvc: params[:cvv]
            },
            billing_details: {
              address: {
                city: params[:city],
                country: "CA",
                line1: params[:address],
                postal_code: params[:postal_code],
                state: params[:province]
              },
              email: "cheleydan@gmail.com",
              # email: @merchant.user.email,
              name: "#{params[:first_name]} #{params[:last_name]}",
              phone: params[:phone],

            }
            # source: params[:stripeToken]
          )
          @billing.stripe_customer_id = customer.id
          @billing.save
        rescue Exception => e
          error = e
        end

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
      def billing_params
        params.require(:billing).permit(:first_name, :last_name, :institution,
          :address, :city, :postal_code, :province, :phone, :merchant_id, :credit_card_number,
          :credit_expiry_date, :cvv, :stripe_customer_id)
      end

      def set_firebase
        @firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
      end
    end
  end
end
