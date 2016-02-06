class PagesController < ApplicationController
  def home
    render layout: 'wide',  :locals => {:background => "doom"}
  end

  def about
    render layout: 'wide',  :locals => {:background => "granite"}
  end
end
