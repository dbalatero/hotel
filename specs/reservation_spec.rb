require_relative 'spec_helper'

describe "Reservation class" do

  describe "Initialize" do

    it "is an instance of Reservation" do
      admin = Hotel::Reservation.new
      admin.must_be_kind_of Hotel::Reservation
    end

  end

end
