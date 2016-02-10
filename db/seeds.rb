class Seed
  def self.start
    create_avatars
    @bree, @rivendell = create_locations
    @armory, @inn, @apothecary, @blacksmith = create_categories
    create_stores
    create_store_items
  end

  def self.create_avatars
    create_avatar("Gandalf","gandalf.jpg", 8, 19, 7, 20, 7, 200)
    create_avatar("Aragorn","aragorn.png", 15, 11, 15, 20, 12, 50)
    create_avatar("Gimli","gimli.jpeg",18, 7, 13, 20, 10, 150)
    create_avatar("Legolas","legolas.jpg", 10, 12, 19, 20, 17, 150)
    create_avatar("Boromir","boromir.jpg", 16, 9, 14, 20, 12, 100)
    create_avatar("Frodo","frodo.jpg", 7, 9, 12, 30, 16, 250)
    create_avatar("Sam","samwise.jpg", 10, 8, 11, 30, 15, 100)
    create_avatar("Merry","merry.jpeg",5, 10, 14, 30, 17, 120)
    create_avatar("Pippen","pippen.jpg",8, 7, 14, 30, 18, 80)
  end

  def self.create_avatar(name, image_url, strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.create(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Avatar.create(name: name, image_url: image_url, skill_set: s)
  end

  def self.create_locations
    [
      Location.create(name: "Bree", slug: "bree", next_location_id: 2),
      Location.create(name: "Rivendell", slug: "rivendell", next_location_id: 3)
    ]
  end

  def self.create_categories
    [
      Category.create(name: "armory"),
      Category.create(name: "inn"),
      Category.create(name: "apothecary"),
      Category.create(name: "blacksmith")
    ]
  end

  def self.create_stores
  @bree_armory = Store.create(category: @armory, location: @bree, name: "HANKS")
  @bree_inn = Store.create(category: @inn, location: @bree, name: "Prancing Pony")
  @bree_apothecary = Store.create(category: @apothecary, location: @bree, name: "Aaron's Drugs")
  @bree_blacksmith = Store.create(category: @blacksmith, location: @bree, name: "HANKS")
  
  @rivendell_armory = Store.create(category: @armory, location:@rivendell, name: "HANKS")
  @rivendell_inn = Store.create(category: @inn, location:@rivendell, name: "Prancing Pony")
  @rivendell_apothecary = Store.create(category: @apothecary, location:@rivendell, name: "Aaron's Drugs")
  @rivendell_blacksmith = Store.create(category: @blacksmith, location:@rivendell, name: "HANKS")
  end

  def self.create_item(name, category, label,  strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.create(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Item.create(name: name, skill_set: s, category: category, label: label)
  end

  def self.create_store_items
    @bree_blacksmith.items = [
      create_item("Dagger", @blacksmith, "sword", 1, 0, 0, 0, 0, -2),
      create_item("Elvish Sword", @blacksmith, "sword", 3, 0, 0, 0, 0, -30),
      create_item("Short Sword", @blacksmith, "sword", 1, 0, 0, 0, 1, -10),
      create_item("Long Sword", @blacksmith, "sword", 2, 0, 0, 0, -1, -20),
      create_item("Heavy Axe", @blacksmith, "axe", 2, 0, 0, 0, -1, -15),
      create_item("Dwarves Axe", @blacksmith, "axe", 2, 0, 0, 0, 0, -23),
      create_item("Long Bow", @blacksmith, "bow", 0, 0, 1, 0, 0, -10),
      create_item("Elvish Bow", @blacksmith, "bow", 0, 0, 3, 0, 0, -40),
      create_item("Recurve Bow", @blacksmith, "bow", 0, 0, 2, 0, 0, -30),
      create_item("Red Oak Staff", @blacksmith, "staff", 0, 2, 0, 0, 0, -20),
      create_item("Sapphire Stone Staff", @blacksmith, "staff", 0, 3, 0, 0, 0, -40)
    ]

    @bree_inn.items = [
      create_item("Water", @inn, "dehydration",  0, 0, 0, 0, 0, -2),
      create_item("Bread", @inn, "starvation", 0, 0, 0, 0, 0, -2),
      create_item("Apple", @inn, "starvation", 0, 0, 0, 0, 0, -3),
      create_item("Cheese", @inn, "starvation", 0, 0, 0, 0, 0, -5),
      create_item("Milk", @inn, "starvation", 0, 0, 0, 0, 0, -3),
      create_item("Sausage", @inn, "starvation", 0, 0, 0, 0, 0, -3),
      create_item("Dried Beans", @inn, "starvation", 0, 0, 0, 0, 0, -3),
      create_item("Salted Beef", @inn, "starvation", 0, 0, 0, 0, 0, -5),
      create_item("Blanket", @inn, "cold", 0, 0, 0, 0, 0, -2)
    ]

    @bree_apothecary.items = [
      create_item("Health Potion", @apothecary, "weakness", 0, 0, 0, 0, 0, -2),
      create_item("Antidote", @apothecary, "poison", 0, 0, 0, 0, 0, -2),
      create_item("Splint", @apothecary, "broken", 0, 0, 0, 0, 0, -3),
      create_item("Bandage", @apothecary, "cut", 0, 0, 0, 0, 0, -5),
      create_item("Ginger Root", @apothecary, "sickness", 0, 0, 0, 0, 0, -3),
      create_item("Osha", @apothecary, "sickness", 0, 0, 0, 0, 0, -1),
      create_item("Comfrey", @apothecary, "infection", 0, 0, 0, 0, 0, -3),
      create_item("Alcohol", @apothecary, "infection", 0, 0, 0, 0, 0, -5)
    ]

    @bree_armory.items = [
      create_item("Light Armor", @armory, "shield", 1, 0, 0, 0, 1, -2),
      create_item("Heavy Armor", @armory, "shield", 3, 0, 0, 0, -1, -2)
    ]

    @rivendell_blacksmith.items = [
      create_item("Dagger", @blacksmith, "sword", 1, 0, 0, 0, 0, -2),
      create_item("Elvish Sword", @blacksmith, "sword", 3, 0, 0, 0, 0, -30),
      create_item("Short Sword", @blacksmith, "sword", 1, 0, 0, 0, 1, -10),
      create_item("Long Sword", @blacksmith, "sword", 2, 0, 0, 0, -1, -20),
      create_item("Heavy Axe", @blacksmith, "axe", 2, 0, 0, 0, -1, -15),
      create_item("Dwarves Axe", @blacksmith, "axe", 2, 0, 0, 0, 0, -23),
      create_item("Long Bow", @blacksmith, "bow", 0, 0, 1, 0, 0, -10),
      create_item("Elvish Bow", @blacksmith, "bow", 0, 0, 3, 0, 0, -40),
      create_item("Recurve Bow", @blacksmith, "bow", 0, 0, 2, 0, 0, -30),
      create_item("Red Oak Staff", @blacksmith, "staff", 0, 2, 0, 0, 0, -20),
      create_item("Sapphire Stone Staff", @blacksmith, "staff", 0, 3, 0, 0, 0, -40)
    ]
    @rivendell_inn.items = [
      create_item("Water", @inn, "dehydration",  0, 0, 0, 0, 0, -2),
      create_item("Bread", @inn, "starvation", 0, 0, 0, 0, 0, -2),
      create_item("Apple", @inn, "starvation", 0, 0, 0, 0, 0, -3),
      create_item("Cheese", @inn, "starvation", 0, 0, 0, 0, 0, -5),
      create_item("Milk", @inn, "starvation", 0, 0, 0, 0, 0, -3),
      create_item("Sausage", @inn, "starvation", 0, 0, 0, 0, 0, -3),
      create_item("Dried Beans", @inn, "starvation", 0, 0, 0, 0, 0, -3),
      create_item("Salted Beef", @inn, "starvation", 0, 0, 0, 0, 0, -5),
      create_item("Blanket", @inn, "cold", 0, 0, 0, 0, 0, -2)
    ]
    @rivendell_apothecary.items = [
      create_item("Health Potion", @apothecary, "weakness", 0, 0, 0, 0, 0, -2),
      create_item("Antidote", @apothecary, "poison", 0, 0, 0, 0, 0, -2),
      create_item("Splint", @apothecary, "broken", 0, 0, 0, 0, 0, -3),
      create_item("Bandage", @apothecary, "cut", 0, 0, 0, 0, 0, -5),
      create_item("Ginger Root", @apothecary, "sickness", 0, 0, 0, 0, 0, -3),
      create_item("Osha", @apothecary, "sickness", 0, 0, 0, 0, 0, -1),
      create_item("Comfrey", @apothecary, "infection", 0, 0, 0, 0, 0, -3),
      create_item("Alcohol", @apothecary, "infection", 0, 0, 0, 0, 0, -5)
    ]
    @rivendell_armory.items = [
      create_item("Light Armor", @armory, "shield", 1, 0, 0, 0, 1, -2),
      create_item("Heavy Armor", @armory, "shield", 3, 0, 0, 0, -1, -2)
    ]
  end
end

Seed.start
