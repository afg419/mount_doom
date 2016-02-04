class CharactersController < ApplicationController
  before_action :user_logged_in?

  def new
    @character = Character.new
    @avatars = Avatar.all
    render layout: 'wide',  :locals => {:background => "shire"}
  end  
end
