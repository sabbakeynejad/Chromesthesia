// Even though there are multiple objects, we still only need one class. 
// No matter how many cookies we make, only one cookie cutter is needed.
class Col { 
  color c;
  float xpos;
  float ypos;
  float xspeed;

  // The Constructor is defined with arguments.
  Col(color tempC, float tempXpos, float tempYpos, float tempXspeed) { 
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    xspeed = tempXspeed;
  }

  void drive() {
    color c = get(int(xpos), int(ypos));
    text(color(c),xpos,ypos+60);
    fill(c);
    rect(xpos, ypos, 40, 40);
    
    color a = get(int(myCol1.xpos),int(myCol1.ypos));
    color b = get(int(myCol2.xpos),int(myCol2.ypos));
    color cc = get(int(myCol3.xpos),int(myCol3.ypos));
    color d = get(int(myCol4.xpos),int(myCol4.ypos));
    color e = get(int(myCol5.xpos),int(myCol5.ypos));
    println(a*-1/100000,b*-1/100000,cc*-1/100000,d*-1/100000,e*-1/100000);
  }
}