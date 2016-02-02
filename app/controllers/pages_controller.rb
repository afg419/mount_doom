class PagesController < ApplicationController
  def home
    render layout: 'wide',  :locals => {:background => "doom"}
  end

  def about

  end
end
