module ReservationsHelper
  def times
    times = [
             "11:00",
             "11:30",
             "13:00",
             "13:30",
             "14:00",
             "15:00",
             "15:30",
             "16:00",
             "16:30",
             "17:00",
             "17:30",
             "18:00",
             "18:30",
             "19:00",
             "19:30",
             "20:00",
             "20:30",
             "21:00",
             "21:30",
             "22:00",
             "22:30",
             "23:00",
             "23:30",
             "24:00",
             "00:30",
             "01:00",
             "01:30",
             "02:00",
             "02:30",
             "03:00",
             "03:30"]
  end

  def check_reservation(reservations, day, time, store_id)
    result = false
    reservations_count = reservations.count
    # 取得した予約データにdayとtimeが一致する場合はtrue,一致しない場合はfalseを返します
    if reservations_count > 1
      reservations.each do |reservation|
        if reservation[:store_id].eql?(store_id)
          result = reservation[:day].eql?(day.strftime("%Y-%m-%d")) && reservation[:time].eql?(time)
          return result if result
        end
      end
    elsif reservations_count == 1
      if reservation[:store_id].eql?(store_id)
        result = reservations[0][:day].eql?(day.strftime("%Y-%m-%d")) && reservations[0][:time].eql?(time)
        return result if result
      end
    end
    return result
  end
end
