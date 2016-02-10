class RouletteService
  attr_reader :origin_location, :target_location, :character, :main_wound, :subsequent_wounds, :found_items, :healed_wounds
  attr_accessor :health_after_game

  def initialize(params, current_character = nil)
    @origin_location = Location.find(params[:location_id])
    @target_location = origin_location.next_location
    @character = current_character
    health = params[:health] ||= character.hp
    @health_after_game = health.to_i
    @armory, @inn, @apothecary, @blacksmith = Category.all
  end

  def generate_travel_event
    return :dead if health_after_game <= 0

    @main_wound = generate_main_wound
    @subsequent_wounds = generate_random_wounds
    @found_items = generate_random_items

    character.items += found_items
    character.incidents += subsequent_wounds + [main_wound]
    @healed_wounds = heal_wounds
    character.save

    return :dead if character.hp <= 0

    :success
  end

  def generate_main_wound
    damage = character.hp - health_after_game
    wound_ss = SkillSet.create(health: -1 * damage)
    Incident.create(name: wound_name, skill_set: wound_ss)
  end


  def generate_random_items
    random = rand(1..100)
    if random > 95
      generate_items(4)
    elsif random > 85
      generate_items(3)
    elsif random > 70
      generate_items(2)
    elsif random > 50
      generate_items(1)
    else
      []
    end
  end

  def generate_random_wounds
    random = rand(1..100)
    if random > 95
      generate_wounds(4)
    elsif random > 85
      generate_wounds(3)
    elsif random > 70
      generate_wounds(2)
    elsif random > 50
      generate_wounds(1)
    else
      []
    end
  end

  def generate_items(n)
    gained_items = []
    n.times do |i|
      item = item_list.sample
      gained_items << item
      item.save
    end
    gained_items
  end

  def generate_wounds(n)
    new_wounds = []
    n.times do |i|
      wound = wound_list.sample
      new_wounds << wound
      wound.save
    end
    new_wounds
  end

  def wound_name
    ["Broken", "Rotting", "Bloodied", "Atrophied", "Infected", "Punctured", "Decaying", "Nazgul evicerated", "Orc shredded your"].sample +
    [" Leg", " Head", " Lung", " Guts", " Bowels", " Foot", " Dreams"].sample
  end

  def item_list
    [create_item("Bandage", @apothecary, "ow", 0, 0, 0, 0, 1, -2), create_item("Bread", @inn, "hunger", 0, 0, 0, 0, 1, -2), create_item("Antidote", @apothecary, "poison", 0, 0, 0, 0, 1, -2)]
  end

  def create_item(name, category, labell, strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.new(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Item.new(name: name, skill_set: s, category: category, label: labell)
  end

  def wound_list
    [create_wound("Cut", @apothecary,"ow",0,0,0,-2,0,10), create_wound("Starvation",@inn, "hunger", 0,0,0,-2,0,10), create_wound("Snake bite", @apothecary, "poison", 0,0,0,-2,0,10), create_wound("Spider bite", @inn, "poison", 0,0,0,-2,0,10)]
  end

  def create_wound(name, category, labell, strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.new(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Incident.new(name: name, skill_set: s, category: category, label: labell)
  end

  def heal_wounds
    wounds = character.incidents
    items = character.items.where(category: [@inn, @apothecary] )

    array = []
    wounds.each do |wound|
      items.each do |item|
        if item.label == wound.label
          array << destroy_if_matching(item, wound)
          break
        end
      end
    end
    array
  end

  def destroy_if_matching(item, wound)
    item_name, wound_name = item.name, wound.name
    item.destroy
    wound.destroy
    "#{item_name} was used to prevent #{wound_name}"
  end
end
