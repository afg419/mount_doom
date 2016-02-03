class JourneyController < ApplicationController
  def show
    render layout: 'wide',  :locals => {:background => "bree"}
  end
end
