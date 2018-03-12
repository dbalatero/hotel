require_relative 'spec_helper'

describe "Reservation class" do

  before do
    start_date = Date.new(2018,5,20)
    end_date = start_date + 4
    @reservation_data = {
      res_id: 8,
      room: Hotel::Room.new(number: 3),
      start_date: start_date,
      end_date: end_date
    }
    @reservation = Hotel::Reservation.new(@reservation_data)
  end

  describe "#booked?(date)" do
    it "returns true if the Reservation is booked on a given date"

    it "returns false if the Reservation is not booked on a given date"

  end

  describe "#cost" do
    it "calculates the total cost of a Reservation" do

    end
  end


end
