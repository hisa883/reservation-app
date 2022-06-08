class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validate :date_before_start
  validate :date_current_today
  validate :date_three_month_end

  validates :day, presence: true
  validates :time, presence: true
  validates :use_time, presence: true
  validates :start_time_h, presence: true
  validates :start_time_m, presence: true


  def self.reservations_after_three_month
    # 今日から3ヶ月先までのデータを取得
    reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    # 配列を作成し、データを格納
    # DBアクセスを減らすために必要なデータを配列にデータを突っ込んでます
    reservation_data = []
    reservations.each do |reservation|
      reservations_hash = {}
      reservations_hash.merge!(day: reservation.day.strftime("%Y-%m-%d"), time: reservation.time, store_id: reservation.store_id)
      reservation_data.push(reservations_hash)
    end
    reservation_data
  end

  def self.check_reservation_day(day)
    if day < Date.current
      return "過去の日付は選択できません。正しい日付を選択してください。"
    elsif day < (Date.current + 1)
      return "当日は選択できません。店舗にお電話お願いします。"
    elsif (Date.current >> 3) < day
      return "3ヶ月以降の日付は選択できません。正しい日付を選択してください。"
    end
  end

  def date_before_start
    errors.add(:day, "は過去の日付は選択できません") if day < Date.current unless day.nil?
  end

  def date_current_today
    errors.add(:day, "は当日は選択できません。予約画面から正しい日付を選択してください。") if day < (Date.current + 1) unless day.nil?
  end

  def date_three_month_end
    errors.add(:day, "は3ヶ月以降の日付は選択できません") if (Date.current >> 3) < day unless day.nil?
  end
end
