require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'

module Hotel
  class FrontDesk
    attr_reader :rooms, :reservations

    def initialize
      @rooms = load_rooms
      # @blocks = [...]
    end

    def make_reservation(start_date:, end_date:)
      check_for_valid_dates!(start_date, end_date)

      room = find_room(start_date, end_date)
      #
      # unless room
      #   raise "NO rooms avaiable"
      # end

      create_reservation(
        # should find_room not find blocked rooms?
        room: room,
        start_date: start_date,
        end_date: end_date
      )
    end

    # def create_reservation_in_block(block)
    #   room = block.gimme_the_first_block
    #
    #   start_date = block.start_date
    #   end_date = block.end_date
    #   rate = block.rate
    #
    #   create_reservation(
    #     room: room
    #     start_date: start_date,
    #     end_date: end_date,
    #     rate: rate
    #   )
    # end

    def find_reservations_for(date)
      @rooms
        .map { |room| room.find_reservations_for(date) }
        .flatten
    end

    def find_room(start_date, end_date)
      available_rooms(start_date, end_date).first
    end

    private

    def available_rooms(start_date, end_date)
      @rooms.find_all do |room|
        room.available?(start_date, end_date)
      end
    end

    def load_rooms
      MAX_ROOMS_COUNT.times.map do |num|
        Hotel::Room.new(number: num + 1)
      end
    end

    def check_for_valid_dates!(sd, ed)
      if sd.class != Date || ed.class != Date
        raise ArgumentError.new("Date must be a Date object")
      elsif ed < sd
        raise ArgumentError.new("start date must be before end date")
      end
    end

    def create_reservation(input)
      room = input[:room]
      reservation = Hotel::Reservation.new(input)

      room.book(reservation)

      reservation
    end
  end
end
