
module Hotel
  class Block
    DISCOUNTED_COST_PER_NIGHT = 125

    attr_reader :start_date, :end_date, :rate

    def initialize(input)
      @start_date = input[:start_date]
      @end_date = input[:end_date]
      @rate = input[:rate] || DISCOUNTED_COST_PER_NIGHT
    end

    def booked_for?(date)
      date_range.include?(date)
    end

  private

    def date_range
      start_date..end_date - 1
    end

  end
end
