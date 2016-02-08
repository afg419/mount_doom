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
      Location.create(name: "Bree", slug: "bree"),
      Location.create(name: "Rivendell", slug: "rivendell")
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

    Store.create(category: @armory, location: @rivendell, name: "TODDS")
    Store.create(category: @inn, location: @rivendell, name: "Beds by Shannon")
    Store.create(category: @apothecary, location: @rivendell, name: "TODDS")
    Store.create(category: @blacksmith, location: @rivendell, name: "Taylor's discount metal things")
  end

  def self.create_item(name, strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.create(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Item.create(name: name, skill_set: s)
  end

  def self.create_store_items
    @bree_blacksmith.items = [
      create_item("Dagger", 1, 0, 0, 0, 0, 2),
      create_item("Elvish Sword", 3, 0, 0, 0, 0, 30),
      create_item("Short Sword", 1, 0, 0, 0, 1, 10),
      create_item("Heavy Axe", 2, 0, 0, 0, -1, 15),
      create_item("Dwarves Axe", 2, 0, 0, 0, 0, 23),
      create_item("Long Sword", 2, 0, 0, 0, -1, 20),
      create_item("Long Bow", 0, 0, 1, 0, 0, 10),
      create_item("Elvish Bow", 0, 0, 3, 0, 0, 40),
      create_item("Recurve Bow", 0, 0, 2, 0, 0, 30),
      create_item("Red Oak Staff", 0, 2, 0, 0, 0, 20),
      create_item("Sapphire Stone Staff", 0, 3, 0, 0, 0, 40)
    ]
    @bree_inn.items = [
      create_item("Water", 0, 0, 0, 0, 0, 2),
      create_item("Bread", 0, 0, 0, 0, 0, 2),
      create_item("Apple", 0, 0, 0, 0, 0, 3),
      create_item("Cheese", 0, 0, 0, 0, 0, 5),
      create_item("Milk", 0, 0, 0, 0, 0, 3),
      create_item("Sausage", 0, 0, 0, 0, 0, 3),
      create_item("Dried Beans", 0, 0, 0, 0, 0, 3),
      create_item("Salted Beef", 0, 0, 0, 0, 0, 5)
    ]
    @bree_apothecary.items = [
      create_item("Health Potion", 0, 0, 0, 0, 0, 2),
      create_item("Antidote", 0, 0, 0, 0, 0, 2),
      create_item("Splint", 0, 0, 0, 0, 0, 3), #broken stuff
      create_item("Bandage", 0, 0, 0, 0, 0, 5), #cut
      create_item("Ginger Root", 0, 0, 0, 0, 0, 3), #heals from being sick
      create_item("Comfrey", 0, 0, 0, 0, 0, 3), #heals cuts
      create_item("Osha", 0, 0, 0, 0, 0, 1) #helps from being sick
    ]
    @bree_armory.items = [
      create_item("Light Armor", 1, 0, 0, 0, 1, 2),
      create_item("Heavy Armor", 3, 0, 0, 0, -1, 2),
    ]
  end
end

Seed.start
