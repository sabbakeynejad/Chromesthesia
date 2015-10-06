import oscP5.*;
import netP5.*;
import processing.video.*;

Capture cam;
OscP5 oscP5Location2;
NetAddress location1;



float myFloat1;
float myFloat2;
float myFloat3;
int red;


void setup() {
  size(400, 400);

  oscP5Location2 = new OscP5(this, 6001);
  location1 = new NetAddress("127.0.0.1", 5001);


  String[] cameras = Capture.list();



  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[21]);
    cam.start();
  }

}


void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);

  color c = get(width/2, height/2);
  fill(c);
  rectMode(CENTER);
  rect(width/2, height/2, 40, 40);

  float r2 = c >> 16 & 0xFF;  
  float g2 = c >> 8 & 0xFF;  
  float b2 = c & 0xFF;  
  
  myFloat1 = r2;
  myFloat2 = g2;
  myFloat3 = b2;

  println(r2);





  streem();
}

void streem() {  
  OscMessage myMessage = new OscMessage("/test");

  myMessage.add("Location 2: Transmit");
  myMessage.add(mouseX);
  myMessage.add(mouseY);
  myMessage.add(myFloat1);
  myMessage.add(myFloat2);
  myMessage.add(myFloat3);



  oscP5Location2.send(myMessage, location1); 
  println("Sending message.");
}

void oscEvent(OscMessage theOscMessage) {  

  String incomingHeader = theOscMessage.get(0).stringValue();
  int incomingMouseX = theOscMessage.get(1).intValue();
  int incomingMouseY = theOscMessage.get(2).intValue();
  float incomingFloat1 = theOscMessage.get(3).floatValue();
  float incomingFloat2 = theOscMessage.get(4).floatValue();
  float incomingFloat3 = theOscMessage.get(5).floatValue();
}