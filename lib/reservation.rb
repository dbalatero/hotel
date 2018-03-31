module Hotel
  class Reservation
    DEFAULT_COST_PER_NIGHT = 200
    attr_reader :start_date, :end_date, :rate

    def initialize(input)
      @start_date = input[:start_date]
      @end_date = input[:end_date]
      @rate = input[:rate] || DEFAULT_COST_PER_NIGHT
    end

    def booked_for?(date)
      date_range.include?(date)
    end

    def cost
      total_nights * @rate
    end

  private

    def total_nights
      (end_date - start_date).to_i
    end

    def date_range
      start_date...end_date
    end
  end
end
