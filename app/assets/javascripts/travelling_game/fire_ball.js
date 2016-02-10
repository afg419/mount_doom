var FireBall = function(origin_x, origin_y, target_x, target_y, damage){
  this.origin_x = origin_x;
  this.origin_y = origin_y;
  this.target_x = target_x;
  this.target_y = target_y;
  this.x = origin_x;
  this.y = origin_y;
  this.damage = damage;
  this.total_distance = Math.sqrt(Math.pow(target_x - origin_x,2) + Math.pow(target_y - origin_y,2))
  this.v_x = 3*(target_x - origin_x)/this.total_distance
  this.v_y = 3*(target_y - origin_y)/this.total_distance
}

FireBall.prototype.distance_travelled = function(){
  return Math.sqrt( Math.pow(this.x - this.origin_x,2) + Math.pow(this.y - this.origin_y,2) )
}


FireBall.prototype.fly = function() {
  this.x += this.v_x;
  this.y += this.v_y;
}

FireBall.prototype.explode = function(entity_array) {
  fill(255,0,0)
  ellipse(this.x, this.y, 75, 75)
  for(j = 0; j < entity_array.length; j++){
    if (this.isWithinRadius(entity_array[j])){
      entity_array[j].hp -= this.damage/4
    }
  }
}

FireBall.prototype.finished_flight = function(){
  return (point_distance(this.x, this.y, this.target_x, this.target_y) < 5)
}

FireBall.prototype.isWithinRadius = function(entity){
  return point_distance(this.x, this.y, entity.x, entity.y) < 75
}

FireBall.prototype.hit = function(entity) {
  return (point_distance(this.x, this.y, entity.x, entity.y) < entity.r + 5)
}

FireBall.prototype.sketch = function(){
  fill(255,100,0)
  ellipse(this.x, this.y, 5,5)
  fill(0,0,0)
}


FireBall.prototype.hit_any = function(entity_array){
  var i = 0;
  var hit = false;
  var hit_entity;

  while(i < entity_array.length){
      if(this.hit(entity_array[i]) && entity_array[i] !== this){
        hit = true;
        hit_entity = entity_array[i]
        break;
      }
      else{i++;}
  }
  return [hit, hit_entity];
};
