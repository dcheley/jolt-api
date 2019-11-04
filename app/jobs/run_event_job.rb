class RunEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    # Schedule next occurence of an event
    RecurringEvents::Schedule.new(event).call
  end
end
