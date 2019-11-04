module Api
  module V1
    class EventsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_event, only: [:show, :update, :destroy]
      before_action :set_firebase, only: [:create, :update, :destroy]

      # GET /events or /merchants/:merchant_id/events
      def index
        if !params[:merchant_id]
          @events = Event.all
        else
          @merchant = Merchant.find(params[:merchant_id])
          @events = @merchant.events
        end

        render json: @events
      end

      # POST /events
      def create
        @event = Event.new(event_params)

        if @event.save
          # Create next occuring event if user indicates the event is recurring
          RecurringEvents::Schedule.new(@event).call if params[:occurence] != "none"
          @firebase.push("events/#{@event.id}", @event)
          render json: @event, status: :created
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /events/1
      def update
        if @event.update(event_params)
          RecurringEvents::Schedule.new(@event).call if params[:occurence] != "none"
          @firebase.update("events", { "#{@event.id}": @event })
          render json: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE /events/1
      def destroy
        @firebase.delete("events/#{@event.id}", {})
        @event.destroy
      end

      private

      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_params
        params.require(:event).permit(:start_time, :end_time, :description, :offer_id, :occurrence, :next_date)
      end

      def set_firebase
        @firebase = Firebase::Client.new(Rails.application.credentials.firebase_url, Rails.application.credentials.firebase_secret)
      end
    end
  end
end
