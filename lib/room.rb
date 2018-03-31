require 'pry'

module Hotel
  MAX_ROOMS_COUNT = 20
  class Room
    attr_reader :number, :reservations, :blocks

    def initialize(number:)
      @number = number
      @reservations = []
      @blocks = []
    end

    def available?(start_date, end_date)
      @reservations.none? do |reservation|
        reservation.booked_for?(start_date) || reservation.booked_for?(end_date)
      end
    end

    def not_blocked?(start_date, end_date)
      @blocks.none? do |block|
        block.booked_for?(start_date) ||
        block.booked_for?(end_date)
      end
    end

    def book(reservation)
      @reservations << reservation
    end

    def hold(block)
      @blocks << block
    end

    def find_reservations_for(date)
      @reservations.find_all { |reservation| reservation.booked_for?(date) }
    end
  end
end
