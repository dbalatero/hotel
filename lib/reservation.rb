module Hotel
  class Reservation
    DEFAULT_COST_PER_NIGHT = 200
    attr_reader :start_date, :end_date

    def initialize(input)
      @start_date = input[:start_date]
      @end_date = input[:end_date]
      @rate = input[:rate] || DEFAULT_COST_PER_NIGHT
    end

    def booked?(date)
      date_range.include?(date)
    end

    # this method is currently calculating accurate cost without ignoring the check-out day...not sure why
    def cost
      total_nights * @rate
    end

  private

    def total_nights
      (end_date - start_date).to_i
    end

    def date_range
      start_date..end_date
    end
  end
end





#
