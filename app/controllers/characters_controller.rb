class CharactersController < ApplicationController
  def show
    render layout: 'wide',  :locals => {:background => "doom"}
  end

  def new
    @character = Character.new
    @avatars = Avatar.active
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

  def create
    current_character.heal_wounds
    redirect_to current_character
  end
end
