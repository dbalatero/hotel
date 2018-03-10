module Hotel

  class Reservation

    attr_reader :start_date, :end_date, :cost

    def initialize(input)
      @start_date = input[:start_date]
      @end_date = input[:end_date]
      @cost = calculate_cost
    end

    def booked?(date)
      date_range.include?(date)
    end


private
    # this method is currently calculating accurate cost without ignoring the check-out day...not sure why
    def calculate_cost
      total_nights = (end_date - start_date).to_i
      cost = total_nights * 200
      return cost
    end

    def duration
      # end date minus start date?
    end

    def date_range
      start_date..end_date
    end

  end

end
