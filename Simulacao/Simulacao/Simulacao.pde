Ball b = new Ball(random(800),random(800),0,0,0);

void setup(){
  size(800,800);
  Servidor s = new Servidor(b);
  s.start();
}

void draw(){
  background(255);
  float[] a = b.getAttributes();
  float[] point = b.getPoint();
  float x = a[2], y = a[3];
  float angle = a[4];
  boolean go_point = b.getGotoPoint();
  angle += a[1];
  
  if(x > 800){
    x = 750;
  }else 
    if(x < 0) x = 50;
    else x+= cos(angle) * a[0];
 
  if(y > 800){
    y = 750;
  }else 
    if(y < 0) y = 50;
    else y+= sin(angle) * a[0];
    
  if(go_point){
    int ix = (int) x;
    int iy = (int) y;
    int px = (int) point[0];
    int py = (int) point[1];
    if(ix == px && iy == py) {b.setVD(0,0);b.setGotoPoint(false);}
  }
  
  
  b.setCoord(x,y,angle);
  
  if(point[0] != -1 && point[1] != -1){
    ellipse(point[0],point[1],4,4);
  }
    
  
  
  fill(0);
  pushMatrix();
  translate(x,y);
  rotate(angle);
  line(0,0,35,0);
  ellipse(0,0,50,50);
  popMatrix();
}