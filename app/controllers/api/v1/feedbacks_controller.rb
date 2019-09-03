module Api
  module V1
    class FeedbacksController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_firebase, only: [:create, :update, :destroy]

      # GET /feedbacks
      def index
        @feedback_messages = Feedback.all

        render json: @feedback_messages
      end

      # POST /feedbacks
      def create
        @feedback = Feedback.new(feedback_params)

        if @feedback.save
          @firebase.push("feedback/#{@feedback.id}", @feedback)
          render json: @feedback, status: :created
        else
          render json: @feedback.errors, status: :unprocessable_entity
        end
      end

      # DELETE /feedbacks/1
      def destroy
        @firebase.delete("feedback/#{@feedback.id}", {})
        @feedback.destroy
      end

      private

      # Only allow a trusted parameter "white list" through.
      def feedback_params
        params.require(:offer).permit(:message, :user_id, :merchant_id)
      end

      def set_firebase
        @firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
      end
    end
  end
end
