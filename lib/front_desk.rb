require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'
require_relative 'block'

module Hotel
  class FrontDesk
    attr_reader :rooms

    def initialize
      @rooms = load_rooms
    end

    def make_reservation(start_date:, end_date:, room_number: nil)
      check_for_valid_dates!(start_date, end_date)

      room = find_available_room_with_number(start_date, end_date, room_number) ||
        find_available_room(start_date, end_date)

      unless room
        raise ArgumentError.new("No rooms available for that date range")
      end

      create_reservation(
        room: room,
        start_date: start_date,
        end_date: end_date
      )
    end

    def make_block(start_date:, end_date:, num_rooms:)
      rooms = available_rooms(start_date, end_date)[0...num_rooms]

      create_block(
        rooms: rooms,
        start_date: start_date,
        end_date: end_date
      )
    end

    def create_reservation_in_block(block)
      room = find_room_with_block(block)

      create_reservation(
        room: room,
        start_date: block.start_date,
        end_date: block.end_date,
        rate: block.rate
      )
    end

    def find_reservations_for(date)
      @rooms
        .map { |room| room.find_reservations_for(date) }
        .flatten
    end

    def find_available_room(start_date, end_date)
      available_rooms(start_date, end_date).first
    end

    def available_rooms(start_date, end_date)
      @rooms.find_all do |room|
        room.available?(start_date, end_date) &&
          room.not_blocked?(start_date, end_date)
      end
    end

    private

    def find_available_room_with_number(start_date, end_date, room_number)
      available_rooms(start_date, end_date)
        .find { |room| room.number == room_number }
    end

    def load_rooms
      MAX_ROOMS_COUNT.times.map do |num| # rubocop:disable
        Hotel::Room.new(number: num + 1)
      end
    end

    def check_for_valid_dates!(start_date, end_date)
      if start_date.class != Date || end_date.class != Date
        raise ArgumentError.new("Date must be a Date object")
      elsif end_date < start_date
        raise ArgumentError.new("Start date must be before end date")
      end
    end

    def create_reservation(input)
      room = input[:room]
      reservation = Hotel::Reservation.new(input)
      room.book(reservation)
      reservation
    end

    def create_block(input)
      rooms = input[:rooms]
      block = Hotel::Block.new(input)
      rooms.each do |room|
        room.hold(block)
      end
      block
    end

    def find_room_with_block(block)
      @rooms.find_all do |room|
        room.blocks.include?(block)
      end.first
    end
  end
end
