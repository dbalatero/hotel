require_relative 'spec_helper'

describe "Room class" do
  let(:room) { Hotel::Room.new(number: 1) }

  describe "#available?" do
    # custom methods for more readable, DRY tests
    def expect_room_to_be_available(start_date, end_date)
      room.available?(start_date, end_date).must_equal true
    end
    def expect_room_to_not_be_available(start_date, end_date)
      room.available?(start_date, end_date).must_equal false
    end

    it "should be available if there are no reservations" do
      expect_room_to_be_available(
      Date.new(2018, 5, 1),
      Date.new(2018, 5, 5)
      )
    end

    describe 'with a reservation' do
      let(:reservation) do
        Hotel::Reservation.new(
        start_date: Date.new(2018, 5, 1),
        end_date: Date.new(2018, 5, 5)
        )
      end

      before { room.book(reservation) }

      it 'should not be available if the start date overlaps' do
        expect_room_to_not_be_available(
        Date.new(2018, 5, 1),
        Date.new(2018, 5, 10)
        )
      end

      it 'should not be available if the end date overlaps' do
        expect_room_to_not_be_available(
        Date.new(2018, 4, 28),
        Date.new(2018, 5, 5)
        )
      end

      it "should be available if no dates overlap" do
        expect_room_to_be_available(Date.new(2018, 4, 20), Date.new(2018, 4, 25))
      end

      it "should not be available if both start and end dates are in existing reservation" do
        expect_room_to_not_be_available(Date.new(2018, 5, 3), Date.new(2018, 5, 10))
      end
    end
  end

  describe "#find_reservations_for(date)" do
    let(:reservation) do
      Hotel::Reservation.new(
      start_date: Date.new(2018, 5, 1),
      end_date: Date.new(2018, 5, 6)
      )
    end
    before { room.book(reservation) }

    it "should return all reservations for particular date" do
      reservations = room.find_reservations_for(Date.new(2018, 5, 5))
      # binding.pry
      reservations.length.must_equal 1
      reservations.first.start_date.must_equal(Date.new(2018, 5, 1))
    end
  end
end
