class Seed
  def self.start
    create_avatars
  end

  def self.create_avatars
    create_avatar("Gandalf","gandalf.jpg", 8, 19, 7, 20)
    create_avatar("Aragorn","aragorn.png", 15, 11, 15, 20)
    create_avatar("Gimli","gimli.jpeg",18, 7, 13, 20)
    create_avatar("Legolas","legolas.jpg", 10, 12, 19, 20)
    create_avatar("Boromir","boromir.jpg", 16, 9, 14, 20)
    create_avatar("Frodo","frodo.jpg", 7, 9, 12, 30)
    create_avatar("Sam","samwise.jpg", 10, 8, 11, 30)
    create_avatar("Merry","merry.jpeg",5, 10, 14, 30)
    create_avatar("Pippen","pippen.jpg",8, 7, 14, 30)
  end

  def self.create_avatar(name, image_url, strength, intelligence, dexterity, health)
    s = SkillSet.create(strength: strength, intelligence: intelligence,
                                          dexterity: dexterity, health: health)
    Avatar.create(name: name, image_url: image_url, skill_set: s)
  end
end

Seed.start
