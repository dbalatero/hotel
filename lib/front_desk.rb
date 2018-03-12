require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'
require_relative 'block'

module Hotel
  class FrontDesk
    attr_reader :rooms, :blocks

    def initialize
      @rooms = load_rooms
      # @blocks = []
    end

    def make_reservation(start_date:, end_date:, **args)
      check_for_valid_dates!(start_date, end_date)
      if args.has_key?(:room) && requested_room_available?(args[:room], start_date, end_date)
        room = requested_room(args[:room])
      else
        # I chose to not raise an error here, and just pick the next available room if the requested one is unavailable.
        room = find_room(start_date, end_date)
        # should find_room not find blocked rooms?
      end
      unless room
        raise ArgumentError.new("No rooms available for that date range")
      end
      create_reservation(
        room: room,
        start_date: start_date,
        end_date: end_date
      )
    end

    def create_block(start_date:, end_date:, num_rooms:, rate:)
      rooms = available_rooms(start_date, end_date)[0..num_rooms]
      block = Hotel::Block.new(start_date: start_date, end_date: end_date)
      rooms.each do |room|
        room.hold(block)
      end
      block
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

    def available_rooms(start_date, end_date)
      @rooms.find_all do |room|
        room.available?(start_date, end_date) && room.not_blocked?(start_date, end_date)
      end
    end

    private

    def requested_room(input)
      @rooms.find { |room| room.number == input }
    end

    def requested_room_available?(number, start_date, end_date)
      room = @rooms.find { |room| room.number == number }
      # binding.pry
      if room.available?(start_date, end_date)
        return true
      else
        return false
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
