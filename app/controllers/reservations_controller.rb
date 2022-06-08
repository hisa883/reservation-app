class ReservationsController < ApplicationController
  before_action :set_store, only: [:index, :new, :create]
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  def index
    @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end

   def new
    @reservation = Reservation.new
    @day = params[:day]
    if Reservation.find_by(user_id: params[:user_id], day: params[:day])
      flash[:danger] = "同じ日に２個以上の予約はできません"
      redirect_to store_reservations_path(@store)
    end
    # @time = params[:time]
    # @start_time = DateTime.parse(@day + " " + @time + " " + "JST")

    message = Reservation.check_reservation_day(@day.to_date)
    if !!message
      flash[:danger] = "#{message}"
      redirect_to store_reservations_path(@store)
    end
    
  end

  def show
  end

  def create
    debugger
    @reservation = Reservation.new(reservation_params)
    @reservation.time = "#{reservation_params[:start_time_h]}:#{reservation_params[:start_time_m]} "
    if @reservation.save
      flash[:success] = "予約しました。"
      redirect_to store_reservation_path(@reservation.store_id, @reservation.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @reservation.time = "#{edit_reservation_params[:start_time_h]}:#{edit_reservation_params[:start_time_m]} "
    if @reservation.update_attributes(edit_reservation_params)
      flash[:success] = "予約内容を変更しました。"
      redirect_to store_reservation_path(@reservation.store_id, @reservation.id)
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    flash[:success] = "予約を削除しました。"
    redirect_to reservations_user_path(current_user)
  end

  def set_store
    @store = Store.find(params[:store_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  private

    def reservation_params
      params.require(:store).permit(reservations: [:day, :user_id, :start_time, :store_id, :use_time, :start_time_h, :start_time_m])[:reservations]
    end 

    def edit_reservation_params
      params.require(:reservation).permit(:day, :start_time, :start_time_h, :start_time_m, :use_time)
    end
end
