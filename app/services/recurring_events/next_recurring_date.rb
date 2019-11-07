class RecurringEvents::NextRecurringDate < Struct.new(:event)
  def calculate
    case event.occurrence
    when "Weekly"
      event.next_date = event.start_time + 1.weeks
      event.start_time += 1.weeks
      event.end_time += 1.weeks
      event.dup
    when "Bi-weekly"
      event.next_date = event.start_time + 2.weeks
      event.start_time += 2.weeks
      event.end_time += 2.weeks
      event.dup
    when "Monthly"
      event.next_date = event.start_time + 1.months
      event.start_time += 1.months
      event.end_time += 1.months
      event.dup
    else
      "No occurrence value found"
    end
  end

  private

  # TODO: Timezone offset
  def offset
  end
end
