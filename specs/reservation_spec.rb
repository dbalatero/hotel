require_relative 'spec_helper'

describe "Reservation class" do

  before do
    start_date = Date.new(2018,5,20)
    end_date = start_date + 4
    @reservation_data = {
      res_id: 8,
      room: Hotel::Room.new(room_number: 3),
      start_date: start_date,
      end_date: end_date
    }
    @reservation = Hotel::Reservation.new(@reservation_data)
  end



end
