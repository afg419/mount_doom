class RouletteService
  attr_reader :origin_location, :target_location, :character
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

    main_wound = generate_main_wound
    character.items += generate_random_items
    character.incidents += generate_random_wounds + [generate_main_wound]
    # character.heals_wounds
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
    [create_item("Someshit", @blacksmith, 0, 0, 0, 0, 1, -2), create_item("Bread", @blacksmith, 0, 0, 0, 0, 1, -2),create_item("Bossass", @blacksmith, 0, 0, 0, 0, 1, -2)]
  end

  def create_item(name, category, strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.new(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Item.new(name: name, skill_set: s, category: category)
  end

  def wound_list
    [create_wound("OW",0,0,0,-2,0,10), create_wound("OW",0,0,0,-2,0,10), create_wound("OW",0,0,0,-2,0,10), create_wound("Spider Bite",0,0,0,-2,0,10)]
  end

  def create_wound(name, strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.new(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Incident.new(name: name, skill_set: s)
  end
end
