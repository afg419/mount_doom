class CharactersController < ApplicationController
  def new
    @character = Character.new
    @avatars = Avatar.all
  end
end
