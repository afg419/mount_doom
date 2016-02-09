module JourneyHelper
  def add_start_items
    @armory, @inn, @apothecary, @blacksmith = Category.all
    case current_character.avatar.name
      when "Gandalf"
        current_character.items = [ create_item("Staff", @blacksmith, 0, 1, 0, 0, 0, 2),
                                    create_item("Robe", @armory, 0, 0, 0, 0, 0, 2)
                                  ]
      when "Aragorn"
        current_character.items = [ create_item("Sword", @blacksmith, 1, 0, 0, 0, 0, 2),
                                    create_item("Dirty Shirt", @armory, 0, 0, 0, -1, 0, 2)
                                  ]
      when "Gimli"
        current_character.items = [ create_item("Axe", @blacksmith, 0, 0, 0, 0, -1, 2),
                                    create_item("Rusty Chainmail", @armory, 1, 0, 0, 0, 0, 2)
                                  ]
      when "Legolas"
        current_character.items = [ create_item("Bow", @blacksmith, 0, 0, 0, 0, -1, 2),
                                    create_item("Elvish Shirt", @armory, 0, 1, 0, 0, 0, 2)
                                  ]
      when "Boromir"
        current_character.items = [ create_item("Sword", @blacksmith, 1, 0, 0, 0, 0, 2),
                                    create_item("Shirt", @armory, 0, 0, 0, -1, 0, 2)
                                  ]
      when "Frodo"
        current_character.items = [ create_item("Hobbit Sword", @blacksmith, 0, 0, 0, 0, 1, 2),
                                    create_item("Shirt", @armory, 0, 0, 0, -1, 0, 2)
                                  ]
      when "Sam"
        current_character.items = [ create_item("Hobbit Sword", @blacksmith, 0, 0, 0, 0, 1, 2),
                                    create_item("Shirt", @armory, 0, 0, 0, -1, 0, 2)
                                  ]
      when "Merry"
        current_character.items = [ create_item("Hobbit Sword", @blacksmith, 0, 0, 0, 0, 1, 2),
                                    create_item("Shirt", @armory, 0, 0, 0, -1, 0, 2)
                                  ]
      when "Pippen"
        current_character.items = [ create_item("Hobbit Sword", @blacksmith, 0, 0, 0, 0, 1, 2),
                                    create_item("Shirt", @armory, 0, 0, 0, -1, 0, 2)
                                  ]
    end
  end

  def create_item(name, category, strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.create(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Item.find_or_create_by(name: name, skill_set: s, category: category)
  end

end
