var Arrow = function(origin_x, origin_y, target_x, target_y){
  this.origin_x = origin_x;
  this.origin_y = origin_y;
  this.target_x = target_x;
  this.target_y = target_y;
  this.x = origin_x;
  this.y = origin_y;
  this.total_distance = Math.sqrt(Math.pow(target_x - origin_x,2) + Math.pow(target_y - origin_y,2))
  this.v_x = 9*(target_x - origin_x)/this.total_distance
  this.v_y = 9*(target_y - origin_y)/this.total_distance
};

Arrow.prototype.distance_travelled = function(){
  return Math.sqrt(Math.pow(this.x - this.origin_x,2) + Math.pow(this.y - this.origin_y,2))
}

Arrow.prototype.fly = function() {
  if (this.x !== this.target_x || this.y !== this.target_y){
    this.x += this.v_x;
    this.y += this.v_y;
  }
}

Arrow.prototype.hit = function(entity) {
  return point_distance(this.x + this.v_x, this.y+this.v_y, entity.x, entity.y) < entity.r
}

Arrow.prototype.sketch = function(){
  strokeWeight(3)
  line(this.x, this.y, this.x + 2*this.v_x, this.y+2*this.v_y)
  strokeWeight(1)
}

Arrow.prototype.hit_any = function(entity_array){
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
