/**
 * Single PLayer Agar.io
 * Random Virus spawn every 5 levels
 * Enemy cell gains radius and speed as level progresses
 * Virus splits any cell if it is more than twice its radius
 * food scattered across to gain radius
 */

//MRect r1, r2, r3, r4;
float rad = 40;
int inc = 5;
int level = 1;
float xPosition;
float yPosition;
ArrayList<Virus> virus = new ArrayList<Virus>();
ArrayList<Food> food = new ArrayList<Food>();
Cell cell = new Cell(1920, 1080, rad*1.5);

void setup()
{
  size(1920, 1080);
  fill(255, 204);
  noStroke();
  virus.add(new Virus(random(100, 980), random(100, 980), random(10, 30)));
  for(int i = 0; i < 20; i ++){
    food.add(new Food(random(100, 980), random(100, 980), random(rad, rad*level)));
  }
  
 // cell.add(new Cell(500, 500, rad + 10));
  //r1 = new MRect(1, 134.0, 0.532, 0.1*height, 10.0, 60.0);
  //r2 = new MRect(2, 44.0, 0.166, 0.3*height, 5.0, 50.0);
  //r3 = new MRect(2, 58.0, 0.332, 0.4*height, 10.0, 35.0);
  //r4 = new MRect(1, 120.0, 0.0498, 0.9*height, 15.0, 60.0);
}
 
void draw()
{
  background(0);
  
  //r1.display();
  //r2.display();
  //r3.display();
  //r4.display();
 
  //r1.move(mouseX-(width/2), mouseY+(height*0.1), 30);
  //r2.move((mouseX+(width*0.05))%width, mouseY+(height*0.025), 20);
  //r3.move(mouseX/4, mouseY-(height*0.025), 40);
  //r4.move(mouseX-(width/2), (height-mouseY), 50);
  
  spawnFood();
  fill(0, 255, 100);
  xPosition = mouseX;
  yPosition = mouseY;
  ellipse(xPosition, yPosition, rad, rad);
  spawnVirus();
  eat();
  virusSplit();
  cell.display();
  eatEnemy();
  
  
}
 
class Food 
{
  public float x;
  public float y;
  public float radius;
 
  Food(float xpos, float ypos, float r){
    x = xpos;
    y = ypos;
    radius = r;
  }
 
  //void move (float posX, float posY, float damping) {
  //  float dif = ypos - posY;
  //  if (abs(dif) > 1) {
  //    ypos -= dif/damping;
  //  }
  //  dif = xpos - posX;
  //  if (abs(dif) > 1) {
  //    xpos -= dif/damping;
  //  }
  //}
 
  void display() {
      fill(255, 255, 255);
      ellipse(x, y, radius, radius);
    
  }
  
}
class Cell 
{
  public float radius;
  public float xpos; // rect xposition
  public float ypos ; // rect yposition
  
  
 
  Cell(float x, float y, float r) {
    xpos = x;
    ypos = y;
    radius = r;
  }
 
  //void move (float posX, float posY, float damping) {
  //  float dif = ypos - posY;
  //  if (abs(dif) > 1) {
  //    ypos -= dif/damping;
  //  }
  //  dif = xpos - posX;
  //  if (abs(dif) > 1) {
  //    xpos -= dif/damping;
  //  }
  //}
 
  
  void display() {
    
      if(radius > rad){ 
      if(xpos < mouseX) xpos += level*1.5;
      else xpos -= level*1.5;
      if(ypos < mouseY) ypos +=1.5*level;
      else ypos -=level*1.5;
      }
      else{
        if(xpos < mouseX) xpos -= level*1.5;
      else xpos += level*1.5;
      if(ypos < mouseY) ypos -=1.5*level;
      else ypos +=level*1.5;
      }
      if(outOfBounds(xpos,ypos)){
        xpos = 200;
        ypos = 200;
      }
      fill(255, 0, 0);
      ellipse(xpos, ypos, radius, radius);
    
  }
  void move(float x, float y){
    xpos = x;
    ypos = y;
  }
}
boolean outOfBounds(float x, float y){
  float xMax = 1920;
  float yMax = 1080;
  if(x > xMax || x < 0 || y < 0 || y > yMax ) return true;
  else return false;
}
class Virus 
{
  
  public float xpos; // rect xposition
  
  public float ypos ; // rect yposition
  
  public float radius;
 
  Virus(float x, float y, float r) {
    
    xpos = x;
    radius = r;
    ypos = y;
  }
 
  //void move (float posX, float posY, float damping) {
  //  float dif = ypos - posY;
  //  if (abs(dif) > 1) {
  //    ypos -= dif/damping;
  //  }
  //  dif = xpos - posX;
  //  if (abs(dif) > 1) {
  //    xpos -= dif/damping;
  //  }
  //}
  //void display() {
  //  for (int i=0; i<t; i++) {
  //    rect(xpos+(i*(d+w)), ypos, w, height*h);
  //  }
  //}
  void display(){
    fill(255, 0, 255);
    ellipse(xpos, ypos, radius, radius);
  }
 
  
}
void spawnVirus(){
  for(int i = 0; i < virus.size(); i++){
    virus.get(i).display();
  }
}
void spawnFood(){
  for(int i = 0; i < food.size(); i++){
    food.get(i).display();
  }
}
void addFood(int num){
  for(int i = food.size(); i < num; i ++){
    food.add(new Food(random(100, 1820), random(100, 980), random(10, 20)));
  }
}
void eat(){
  for(int i = 0; i < food.size(); i++){
    if(inBounds(food.get(i).x, food.get(i).y, true)){
      rad += inc;
      food.remove(i);
    }
  }
}
boolean inBounds(float x, float y, boolean mouse){
  float dist;
  if (mouse)
  dist = sqrt(pow(x - mouseX,2) + pow(y - mouseY,2));
  else dist =  sqrt(pow(x - cell.xpos,2) + pow(y - mouseY,2));
  if(dist < rad) return true;
  else return false;
}
void virusSplit(){
  for(int i = 0; i < virus.size(); i++){
    if(inBounds(virus.get(i).xpos, virus.get(i).ypos, true) && rad/2 > virus.get(i).radius){
      rad/=2;
      food.add(new Food(random(100, 1820), random(100, 980), rad/1.5));
      
    }
    if(inBounds(virus.get(i).xpos, virus.get(i).ypos, false) && cell.radius/2 > virus.get(i).radius){
      cell.radius /= 2;
    }
  }
}
void eatEnemy(){
  
    if(inBounds(cell.xpos, cell.ypos, true)){
      if(rad >= cell.radius){
      //inc += 2;
      rad = 40;
      level ++;
      
      addFood(20 + level *10);
      cell.move(1080, 1080);
      cell.radius *= 1.5;
      if(level%5 == 0) virus.add(new Virus(random(100, 1820), random(100, 980), 10));
      }
      else if(rad < cell.radius){
       rad = 0;
      //level--;
      //addFood(20);
      exit();
      }
    }
  
}
