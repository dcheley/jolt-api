class RecurringEvents::Schedule < Struct.new(:event)
  def call
    next_event = RecurringEvents::NextRecurringDate.new(event).calculate
    if !next_event.instance_of? String
      event = Event.new(next_event.attributes)
      event.save && schedule_background_job(event)
      event
    end
  end

  private

  def schedule_background_job(event)
    NextEventJob.set(wait_until: event.next_date).perform_later(event)
  end
end
