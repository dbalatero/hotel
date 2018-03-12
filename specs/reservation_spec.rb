require_relative 'spec_helper'

describe "Reservation class" do

  let(:reservation) { Hotel::Reservation.new(start_date: Date.new(2018, 3, 15), end_date: Date.new(2018, 3, 18)) }

  describe "#booked?(date)" do
    it "returns true if the Reservation is booked on a given date" do
      reservation.booked?(Date.new(2018, 3, 16)).must_equal true
    end

    it "returns false if the Reservation is not booked on a given date" do
      reservation.booked?(Date.new(2018, 4, 1)).must_equal false
    end
  end

  describe "#cost" do
    it "calculates the total cost of a Reservation" do
      reservation.cost.must_equal 600
    end

    it "sets the appropriate rate given the input" do
      new_reservation = Hotel::Reservation.new(start_date: Date.new(2018, 3, 15), end_date: Date.new(2018, 3, 18), rate: 150)
      new_reservation.cost.must_equal 450
    end
  end


end
