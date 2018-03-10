require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'

module Hotel

  class FrontDesk

    attr_reader :rooms, :reservations

    def initialize
      @rooms = load_rooms
    end

    def make_reservation(start_date:, end_date:)
      if check_dates(start_date, end_date)
        room = find_room(start_date, end_date)

        reservation_data = {
          room: room,
          start_date: start_date,
          end_date: end_date
        }
        reservation = create_reservation(reservation_data)
        room.book(reservation)

      end
      reservation
    end

    def find_reservations_for(date)
      @rooms.map { |room| room.find_reservations_for(date) }.flatten
    end

    def find_room(start_date, end_date)
      @rooms.find do |room|
        room.available?(start_date, end_date)
      end
    end


    private

    def load_rooms
      MAX_ROOMS_COUNT.times.map do |num|
        Hotel::Room.new(number: num + 1)
      end
    end

    def check_dates(sd, ed)
      if sd.class != Date || ed.class != Date
        raise ArgumentError.new("Date must be a Date object")
      elsif ed < sd
        return false
      else
        return true
      end
    end

    def create_reservation(input)
      Hotel::Reservation.new(input)
    end



  end


end
#
# front_desk = Hotel::FrontDesk.new
# front_desk.make_reservation(start_date: Date.new(2018,6,7), end_date: Date.new(2018,6,19))
