var EnemyMelee = function(hp,x,y,r,str,dex,int,spd,col,active,ac,range){
  Entity.call(this,hp,x,y,r,str,dex,int,spd,col,active,ac)
  this.range = range;
};

EnemyMelee.prototype = Object.create(Entity.prototype);

EnemyMelee.prototype.chase = function(player){
  if (player.x < this.x){
    this.x -= this.spd;
  }

  if (player.x > this.x){
    this.x += this.spd;
  }

  if (player.y < this.y){
    this.y -= this.spd;
  }

  if (player.y > this.y){
    this.y += this.spd;
  }
}

EnemyMelee.prototype.collision_rebound_from = function(colliding_entity){
  rand = Math.floor((Math.random() * 4) + 1)
  if (rand === 1) {
    this.x += (0.5)*this.spd;
  }

  if (rand === 2) {
    this.x -= (0.5)*this.spd;
  }

  if (rand === 3) {
    this.y += (0.5)*this.spd;
  }

  if (rand === 4) {
    this.y -= (0.5)*this.spd;
  }

  if (colliding_entity.x < this.x){
    this.x += this.spd;
  }

  if (colliding_entity.x > this.x){
    this.x -= this.spd;
  }

  if (colliding_entity.y < this.y){
    this.y += this.spd;
  }

  if (colliding_entity.y > this.y){
    this.y -= this.spd;
  }
}

EnemyMelee.prototype.attack = function(enemy, timer){
  rand = Math.floor((Math.random() * 24) + 1)
  if (timer % 25 == rand && this.distance(enemy) < 45 + this.range) {
    stroke(255,0,0)
    strokeWeight(4);
    line(this.x, this.y, enemy.x, enemy.y);
    enemy.hp -= this.str/(5+enemy.ac)
    stroke(0,0,0)
    strokeWeight(1);
  }
}

EnemyMelee.prototype.react = function(player_enemies){
  collider = this.collision_with_any(player_enemies);
  if (collider[0]){
    this.collision_rebound_from(collider[1]);
  } else {
    this.chase(player_enemies[0]);
  }
}
