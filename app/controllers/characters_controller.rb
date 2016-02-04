class CharactersController < ApplicationController
  before_action :user_logged_in?
  before_action :in_game2?, only:[:show]

  def show
    render layout: 'wide',  :locals => {:background => "doom"}
  end

  def new
    @character = Character.new
    @avatars = Avatar.all
    render layout: 'wide',  :locals => {:background => "shire"}
  end
end
