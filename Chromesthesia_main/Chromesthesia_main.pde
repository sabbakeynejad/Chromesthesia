import processing.video.*;
int[] numbers = new int[3];
//numbers[0] = 90;  // Assign value to first element in the array
//numbers[1] = 150; // Assign value to second element in the array


Capture cam;

void setup() {
  size(640, 480);

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
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
  for(int i =0; i < 3; i++){
   numbers[i] = 10*i;
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
  // color c = get(mouseX,mouseY);
  //println(c);

  noStroke();

 println(numbers);



  for (int x = 0; x < width; x = x+200) {
    for (int y = 0; y < height; y = y+200) {

      color c = get(x, y);
      text(color(c), x, y + 60);
      fill(c);
    
      rect(x, y, 40, 40);
    }
  }
}