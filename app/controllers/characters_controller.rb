class CharactersController < ApplicationController
  def show
    render layout: 'wide',  :locals => {:background => "doom"}
  end

  def new
    @character = Character.new
    @avatars = Avatar.all
    render layout: 'wide',  :locals => {:background => "shire"}
  end

  def update
    equippable = Item.find(params[:item])
    case equippable.category.name
    when "blacksmith" then current_character.equip_weapon(equippable)
    when "armory" then current_character.equip_armor(equippable)
    end
    redirect_to current_character
  end
end
