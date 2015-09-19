import processing.video.*;
int[] numbers = new int [1];
Capture cam;

Col myCol1;
Col myCol2;
Col myCol3;
Col myCol4;
Col myCol5;

void setup() {
  size(500, 500);
  // Parameters go inside the parentheses when the object is constructed.
  String[] cameras = Capture.list();

  myCol1 = new Col(color(255, 0, 0), 0, 250, 2);  
  myCol2 = new Col(color(255, 0, 0), 100, 250, 2);
  myCol3 = new Col(color(255, 0, 0), 200, 250, 2);
  myCol4 = new Col(color(255, 0, 0), 300, 250, 2);
  myCol5 = new Col(color(255, 0, 0), 400, 250, 2);


  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
  //    println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {
  background(250);

  if (cam.available() == true) {
    cam.read();
  }
  
  image(cam, 0, 0);


  noStroke();


  
  myCol1.drive();
  myCol2.drive();
  myCol3.drive();
  myCol4.drive();
  myCol5.drive();

}

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