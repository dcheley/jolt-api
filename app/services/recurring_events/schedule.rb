class RecurringEvents::Schedule < Struct.new(:event)
  def call
    next_date = NextRecurringDate.new(event).calculate
    event = Event.new(next_date: next_date)
    event.save && schedule_background_job(event)
  end

  private

  def schedule_background_job(event)
    RunEventJob.set(wait_until: event.next_date).perform_later(event)
  end
end
