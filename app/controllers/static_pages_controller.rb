class StaticPagesController < ApplicationController
  require 'rspotify'
  
  def top
    if params[:search].present?
    @searchartists = RSpotify::Artist.search(params[:search])
    end
  end
end
