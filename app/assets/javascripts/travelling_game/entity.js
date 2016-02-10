var Entity = function(hp,x,y,r,str,dex,int,spd,col,active,ac){
  this.hp = hp;

  this.x = x;
  this.y = y;
  this.r = r;

  this.str = str;
  this.dex = dex;
  this.int = int;
  this.spd = spd;

  this.ac = ac;

  this.active = active; //indicates what kind of attack

  this.col = col;
}

Entity.prototype.sketch = function(){
  fill(this.col)
  ellipse(this.x, this.y, this.r, this.r)
}

var point_distance = function(x1, y1, x2, y2){
  return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2,2) );
}

Entity.prototype.distance = function(entity){
  return point_distance(entity.x, entity.y, this.x, this.y);
}

Entity.prototype.collision_with_one = function(entity2){
  return (this.distance(entity2) < (2/3)*(this.r + entity2.r))
}

Entity.prototype.dead = function() {
  return this.hp <= 0
}

Entity.prototype.collision_with_any = function(entity_array){
  var i = 0;
  var collision = false;
  var colliding_entity;

  while(i < entity_array.length){
      if(this.collision_with_one(entity_array[i]) && entity_array[i] !== this){
        collision = true;
        colliding_entity = entity_array[i]
        break;
      }
      else{i++;}
  }
  return [collision, colliding_entity];
};
