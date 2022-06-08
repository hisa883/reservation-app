class StoresController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :set_store, only: [:show]
  before_action :logged_in_user, only: [:index]

  def index
    @stores = Store.all
    
  end

  def show
    
  end

  private

    def set_store
      @store = Store.find(params[:id])
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
end
