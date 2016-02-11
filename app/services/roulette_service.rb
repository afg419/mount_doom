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
    @main_wound = generate_main_wound
    @subsequent_wounds = generate_random_wounds
    @found_items = generate_random_items

    character_acquires_items_and_wounds(found_items,
                                        subsequent_wounds + [main_wound])
    if_alive_then_heal


    health_after_game <= 0 ? :dead : :success
  end

  def if_alive_then_heal
    if health_after_game > 0
      @healed_wounds = @character.heal_wounds
      @character.save
    else
      @healed_wounds = []
    end
  end

  def character_acquires_items_and_wounds(items, wounds)
    character.items += items
    character.incidents += wounds
    character.save
  end

  def generate_main_wound
    damage = character.hp - health_after_game
    wound_ss = SkillSet.create(health: -1 * damage, money: (damage + 4))
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


  def create_item(name, category, label, strength, defense, intelligence, dexterity, health, speed, money)
    s = SkillSet.new(strength: strength, defense: defense, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Item.new(name: name, skill_set: s, category: category, label: label)
  end


  def create_wound(name, category, label, strength, defense, intelligence, dexterity, health, speed, money)
    s = SkillSet.new(strength: strength, defense: defense, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Incident.new(name: name, skill_set: s, category: category, label: label)
  end

  def item_list
    [
      create_item("Bandage", @apothecary, "cut", 0, 0, 0, 0, 0, 1, -2),
      create_item("Bandage", @apothecary, "cut", 0, 0, 0, 0, 0, 0, -5),
      create_item("Comfrey", @apothecary, "cut", 0, 0, 0, 0, 0, 0, -3),
      create_item("Comfrey", @apothecary, "cut", 0, 0, 0, 0, 0, 0, -3),
      create_item("Bread", @inn, "starvation", 0, 0, 0, 0, 0, 1, -2),
      create_item("Antidote", @apothecary, "poison", 0, 0, 0, 0, 0, 1, -2),
      create_item("Antidote", @apothecary, "poison", 0, 0, 0, 0, 0, 0, -2),
      create_item("Health Potion", @apothecary, "weakness", 0, 0, 0, 0, 0, 0, -2),
      create_item("Splint", @apothecary, "broken", 0, 0, 0, 0, 0, 0, -3),
      create_item("Ginger Root", @apothecary, "sickness", 0, 0, 0, 0, 0, 0, -3),
      create_item("Osha", @apothecary, "sickness", 0, 0, 0, 0, 0, 0, -1),
      create_item("Alcohol", @apothecary, "infection", 2, -5, 0, 0, 0, 0, -5),
      create_item("Eye of Balrog", @blacksmith, "melee", 0, 0, 40, 0, -25, 3, -150),
      create_item("Shimmering Amulet", @apothecary, "fixed", 0, 0, 0, 0, 25, 0, -100),
      create_item("Sun Amulet", @apothecary, "fixed", 5, 0, 5, 5, 5, 0, -80),
      create_item("Moon Amulet", @apothecary, "fixed", 0, 5, 0, 0, 0, 5, -80),
      create_item("Old Panacea", @apothecary, "fixed", 0, 0, 0, 0, 15, 0, -100),
      create_item("Old Panacea", @apothecary, "fixed", 0, 0, 0, 0, 15, 0, -100),
      create_item("Old Panacea", @apothecary, "fixed", 0, 0, 0, 0, 15, 0, -100),
      create_item("Old Panacea", @apothecary, "fixed", 0, 0, 0, 0, 15, 0, -100),
      create_item("Ancient Panacea", @apothecary, "fixed", 0, 0, 5, 0, 30, 0, -150),
      create_item("Steel blade Axe", @blacksmith, "melee", 12, 0, 0, 0, 0, -6, -100),
      create_item("Narya of the Red Stone", @apothecary, "melee", 20, 0, 0, 0, 0, 0, -200),
      create_item("Nenya of the White Stone", @apothecary, "melee", 8, 0, 0, 0, 0, 4, -60),
      create_item("Vilya of the Blue Stone", @apothecary, "melee", 8, 0, 0, 0, 0, 4, -60),
      create_item("Glimmering Full Player", @armory, "shield", 0, 25, 0, 0, 15, -8, -150),
      create_item("Leather Armor", @armory, "shield", 0, 6, 0, 0, 0, 4, -40),
      create_item("Assassin's Leathers", @armory, "shield", 0, 10, 0, 0, -15, 10, -180),
      create_item("Studded Leather Armor", @armory, "shield", 0, 7, 0, 0, 0, 0, -40),
      create_item("Fox Furs", @armory, "shield", 0, 2, 0, 0, 0, 7, -75),
      create_item("Force Field", @armory, "shield", 0, 15, 10, 0, 0, 2, -150),
      create_item("Bow of the Sky", @blacksmith, "bow", 0, -5, 0, 20, 0, 5, -150),

    ]
  end

  def wound_list
    [
      create_wound("Cut", @apothecary,"cut", 0, 0, 0, 0, -2, 0, 10),
      create_wound("Further Injury", @apothecary,"broken", 0, 0, 0, 0, -2, 0, 10),
      create_wound("Flu", @apothecary, "sickness", 0, 0, 0, 0, -4, 0, 10),
      create_wound("Sickness", @apothecary, "sickness", 0, 0, 0, 0, -5, 0, 10),
      create_wound("Infection", @apothecary, "infection", 0, 0, 0, 0, -10, 0, 10),
      create_wound("Snake bite", @apothecary, "poison", 0, 0, 0, 0, -8, 0, 10),
      create_wound("Spider bite", @apothecary, "poison", 0, 0, 0, 0, -10, 0, 10),
      create_wound("Spider bite", @apothecary, "poison", 0, 0, 0, 0, -10, 0, 10),
      create_wound("Starvation", @inn, "starvation", 0, 0, 0, 0, -7, 0, 10),
      create_wound("Hunger",@inn, "starvation", 0, 0, 0, 0, -2, 0, 10),
      create_wound("Starvation",@inn, "starvation", 0, 0, 0, 0, -6, 0, 10),
      create_wound("Being Thirsty!",@inn, "dehydration", 0, 0, 0, 0, -2, 0, 10),
      create_wound("Dehydration",@inn, "dehydration", 0, 0, 0, 0, -10, 0, 10),
      create_wound("Freezing to Death",@inn, "cold", 0, 0, 0, 0, -9, 0, 10),
      create_wound("Exhaustion",@inn, "exhaustion", 0, 0, 0, 0, -2, 0, 10)
    ]
  end
end
