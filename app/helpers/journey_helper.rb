module JourneyHelper
  def add_start_items
    {
      "Gandalf" => current_character.items = [
        create_item("Staff", 0, 0, 0, 0, 0, 2),
        create_item("Robe", 0, 0, 0, 0, 0, 2)
      ],
      "Aragorn" => current_character.items = [
        create_item("Sword", 0, 0, 0, 0, 0, 2),
        create_item("Dirty Shirt", 0, 0, 0, 0, 0, 2)
      ],
      "Gimli" => current_character.items = [
        create_item("Axe", 0, 0, 0, 0, 0, 2),
        create_item("Shirt", 0, 0, 0, 0, 0, 2)
      ],
      "Legolas" => current_character.items = [
        create_item("Bow", 0, 0, 0, 0, 0, 2),
        create_item("Elvish Shirt", 0, 0, 0, 0, 0, 2)
      ],
      "Boromir" => current_character.items = [
        create_item("Sword", 0, 0, 0, 0, 0, 2),
        create_item("Shirt", 0, 0, 0, 0, 0, 2)
      ],
      "Frodo" => current_character.items = [
        create_item("Sword", 0, 0, 0, 0, 0, 2),
        create_item("Shirt", 0, 0, 0, 0, 0, 2)
      ],
      "Sam" => current_character.items = [
        create_item("Sword", 0, 0, 0, 0, 0, 2),
        create_item("Shirt", 0, 0, 0, 0, 0, 2)
      ],
      "Merry" => current_character.items = [
        create_item("Sword", 0, 0, 0, 0, 0, 2),
        create_item("Shirt", 0, 0, 0, 0, 0, 2)
      ],
      "Pippen" => current_character.items = [
        create_item("Sword", 0, 0, 0, 0, 0, 2),
        create_item("Shirt", 0, 0, 0, 0, 0, 2)
      ]
    }
  end
  def create_item(name, strength, intelligence, dexterity, health, speed, money)
    s = SkillSet.create(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health,
                                          speed: speed, money: money)
    Item.create(name: name, skill_set: s)
  end
end
