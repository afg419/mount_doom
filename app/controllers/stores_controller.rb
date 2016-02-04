class StoresController < ApplicationController
  def show
    render layout: 'wide',  :locals => {:background => "armory"}
  end
end
