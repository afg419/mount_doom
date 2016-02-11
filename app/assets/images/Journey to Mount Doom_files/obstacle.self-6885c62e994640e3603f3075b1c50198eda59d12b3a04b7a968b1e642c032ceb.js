var Obstacle = function(hp,x,y,r,str,dex,int,spd,col,active){
  Entity.call(this,hp,x,y,r,str,dex,int,spd,col,active)
};

Obstacle.prototype = Object.create(Entity.prototype);
