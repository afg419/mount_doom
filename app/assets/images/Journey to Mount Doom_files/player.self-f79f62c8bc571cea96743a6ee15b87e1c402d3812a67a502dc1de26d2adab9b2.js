var Player = function(hp,x,y,r,str,dex,int,spd,col,active,ac){
  Entity.call(this,hp,x,y,r,str,dex,int,spd,col,active,ac)
};

Player.prototype = Object.create(Entity.prototype);

Player.prototype.attack = function(timer){
  if (this.active == "melee"){
    total_distance = point_distance(this.x, this.y, mouseX, mouseY)
    stroke(0,0,255)
    strokeWeight(4);
    line(this.x, this.y, 35*(mouseX - this.x)/total_distance + this.x, 35*(mouseY - this.y)/total_distance + this.y);
    stroke(0,0,0)
    strokeWeight(1);
  }

  if (this.active == "bow" && timer > 30){
    total_distance = point_distance(this.x, this.y, mouseX, mouseY)
    player_arrows.push(new Arrow(35*(mouseX - this.x)/total_distance + this.x, 35*(mouseY - this.y)/total_distance + this.y, mouseX, mouseY, this.dex));
  }

  if (this.active == "magic"){
    total_distance = point_distance(this.x, this.y, mouseX, mouseY)
    player_magic.push(new FireBall(35*(mouseX - this.x)/total_distance + this.x, 35*(mouseY - this.y)/total_distance + this.y, mouseX, mouseY, this.int));
  }
}

Player.prototype.melee_hit = function(enemy,x,y){
  return point_distance(35*(x - this.x)/total_distance + this.x, 35*(y - this.y)/total_distance + this.y, enemy.x, enemy.y) < enemy.r
}

// Player.prototype.would_collide_with = function(entity_array, direction_num){
//   x = this.x
//   y = this.y
//   s = this.spd
//   change = [[x,y + s], [x,y - s],[x + s,y], [x -s,y]]
//
//
//   p = new Player(5, change[direction_num][0], change[direction_num][1])
//   return p.collision_with_any(entity_array)[0]
// }
