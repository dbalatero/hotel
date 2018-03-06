require_relative 'spec_helper'

describe "Reservation class" do

  before do
    start_date = Date.parse('2018-05-20')
    end_date = start_date + 4
    @reservation_data = {
      res_id: 8,
      room: Hotel::Room.new(room_number: 3),
      start_date: start_date,
      end_date: end_date
    }
    @reservation = Hotel::Reservation.new(@reservation_data)
  end

  describe "initialize" do

    it "is an instance of Reservation" do
      @reservation.must_be_kind_of Hotel::Reservation
    end

    it "stores an instance of room" do
      @reservation.room.must_be_kind_of Hotel::Room
    end

  end

end
