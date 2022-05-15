class StaticPagesController < ApplicationController
  require 'rspotify'
  
  def top
    ENV['ACCEPT_LANGUAGE'] = "ja"
    if params[:search].present?
      @searchartist = RSpotify::Artist.find(params[:search])
    else
      @Top_list = RSpotify::Playlist.find('spotify', '6Mm5y1PZJDdEXl61waypUp')
    end
    
  end
end
