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

    def make_reservation(start_date:, end_date:, **args)
      check_for_valid_dates!(start_date, end_date)
      if args.has_key?(:room) && requested_room_available?(args[:room], start_date, end_date)
        room = @rooms.find { |room| room.number == args[:room] }
      else
        room = find_room(start_date, end_date)
      end
      unless room
        raise ArgumentError.new("No rooms available for that date range")
      end
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

    def requested_room_available?(number, start_date, end_date)
      room = @rooms.find { |room| room.number == number }
      # binding.pry
      if room.available?(start_date, end_date)
        return true
      else
        return false
      end
    end

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

    def check_for_valid_dates!(start_date, end_date)
      if start_date.class != Date || end_date.class != Date
        raise ArgumentError.new("Date must be a Date object")
      elsif end_date < start_date
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
