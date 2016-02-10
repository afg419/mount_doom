var EnemyRanged = function(hp,x,y,r,str,dex,int,spd,col,active){
  Entity.call(this,hp,x,y,r,str,dex,int,spd,col,active);
  this.arrows = [];
};

EnemyRanged.prototype = Object.create(Entity.prototype);

EnemyRanged.prototype.dodge = function(player){
  if (player.x < this.x){
    this.x += this.spd;
  }

  if (player.x > this.x){
    this.x -= this.spd;
  }

  if (player.y < this.y){
    this.y += this.spd;
  }

  if (player.y > this.y){
    this.y -= this.spd;
  }
}

EnemyRanged.prototype.chase = function(player){
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


EnemyRanged.prototype.collision_rebound_from = function(colliding_entity){
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

EnemyRanged.prototype.attack = function(enemy, timer, arrows){
  if (timer % 50 == 0) {
    arrows.push(new Arrow(this.x, this.y, enemy.x, enemy.y));
  }
}


EnemyRanged.prototype.react = function(player_enemies){
  collider = this.collision_with_any(player_enemies);
  if (collider[0]){
    this.collision_rebound_from(collider[1]);
  }

  if (this.distance(player_enemies[0]) < 150) {
    this.dodge(player_enemies[0]);
  }

  if (this.distance(player_enemies[0]) > 250) {
    this.chase(player_enemies[0]);
  }
}
