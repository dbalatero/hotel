require_relative 'spec_helper'

describe "Room class" do

  describe "#available?" do
    it "should be available if there are no reservations" do
      room = Hotel::Room.new(number: 1)
      room.available?(Date.new(2018, 5, 1), Date.new(2018, 5, 5)).must_equal true
    end

    it "should not be available if the start date overlaps" do
      room = Hotel::Room.new(number: 1)
      reservation = Hotel::Reservation.new(start_date: Date.new(2018, 5, 1), end_date: Date.new(2018, 5, 5) )
      room.book(reservation)

      room.available?(Date.new(2018, 5, 1), Date.new(2018, 5, 10)).must_equal false
    end

    it "should not be available if the end date overlaps" do
      room = Hotel::Room.new(number: 1)
      reservation = Hotel::Reservation.new(start_date: Date.new(2018, 5, 1), end_date: Date.new(2018, 5, 5) )
      room.book(reservation)

      room.available?(Date.new(2018, 4, 28), Date.new(2018, 5, 5)).must_equal false
    end

    it "should be available if no dates overlap" do
      room = Hotel::Room.new(number: 1)
      reservation = Hotel::Reservation.new(start_date: Date.new(2018, 5, 1), end_date: Date.new(2018, 5, 5) )
      room.book(reservation)

      room.available?(Date.new(2018, 4, 20), Date.new(2018, 4, 25)).must_equal true
    end

    it "should not be available if both start and end dates are in existing reservation" do
      room = Hotel::Room.new(number: 1)
      reservation = Hotel::Reservation.new(start_date: Date.new(2018, 5, 1), end_date: Date.new(2018, 5, 15) )
      room.book(reservation)

      room.available?(Date.new(2018, 5, 3), Date.new(2018, 5, 10)).must_equal false
    end
  end

end
