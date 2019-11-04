class RecurringEvents::NextRecurringDate < Struct.new(:event)
  def calculate
    case event.occurrence
    when "Weekly"
      event.next_date = event.start_time + 1.weeks
    when "Bi-weekly"
      event.next_date = event.start_time + 2.weeks
    when "Monthly"
      event.next_date = event.start_time + 1.months
    date = event.next_date
    else
      "No occurrence value found"
    end
  end

  private

  # TODO: Timezone offset
  def offset
  end
end
