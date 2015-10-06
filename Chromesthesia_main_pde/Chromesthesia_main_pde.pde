
// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).
Minim minim;
AudioOutput out;
BandPass   bpf;


PVector mousePos;
float inc;
// BumpyInstrument is an example of using an Oscil to run through
// a wave over the course of a note being played.  This is also an
// example of creating a wave using the WavetableGenerator gen7 function.

// Every instrument must implement the Instrument interface so 
// playNote() can call the instrument's methods.
class BumpyInstrument implements Instrument
{
  // create all variables that must be used throughout the class
  Oscil toneOsc, envOsc;

  // constructor for this instrument  
  BumpyInstrument( String pitch, float amplitude )
  {    
    // calculate the frequency for the oscillator from the note name    
    float frequency = Frequency.ofPitch( pitch ).asHz();

    // create a wave for the amplitude envelope.
    // The name of the method "gen7" is a reference to a genorator in Csound.
    // This is a somewhat silly, but demonstrative wave.  It rises from 0 to 1
    // over 1/8th of the time, then goes to 0.15 over 1/8th of it's time, then
    // rises to 1 again over 1/128th of it's time, and then decays again to 0
    // for the rest of the time.  
    // Note that this envelope is of fixed shape regardless of duration.
    Wavetable myEnv = WavetableGenerator.gen7( 8192, 
      new float[] { 0.00, 1.00, 0.15, 1.00, 0.00 }, 
      new int[]   { 1024, 1024, 64, 6080 } );

    // create new instances of any UGen objects as necessary
    // The tone is the first five harmonics of a square wave.
    toneOsc = new Oscil( frequency, 1.0f, Waves.squareh( 5 ) );
    envOsc = new Oscil( 1.0f, amplitude, myEnv );

    // patch everything up to the output
    envOsc.patch( toneOsc.amplitude );
  }

  // every instrument must have a noteOn( float ) method
  void noteOn( float dur )
  {
    // the duration of the amplitude envelope is set to the length of the note
    envOsc.setFrequency( 1.0f/dur );
    // the tone ascillator is patched directly to the output.
    toneOsc.patch( out );
  }

  // every instrument must have a noteOff() method
  void noteOff()
  {
    // unpatch the tone oscillator when the note is over
    toneOsc.unpatch( out );
  }
}

///////////////////////////////////

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).



// Camera and video 
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
    cam = new Capture(this, cameras[4]);
    cam.start();
  }


  minim = new Minim( this );
  out = minim.getLineOut();
  mousePos = new PVector (mouseX, mouseY);
  bpf = new BandPass(440, 20, out.sampleRate());
  out.addEffect(bpf);
}

void draw() {

  //display Camera if you find it
  if (cam.available() == true) {
    cam.read();
  }

  image(cam, 0, 0);


  //Sound CLass Draw
  mousePos.x = mouseX;


  for (int i = 1; i < 10; i++) {
    noFill();
    //rect(50*i, 0, 50, height); 
    println(50*i);
  }


  if ( mousePos.x > 0 && mousePos.x < 50) {

    playNotes1();
  }
  if ( mousePos.x > 50 && mousePos.x < 100) {

    playNotes2();
  }
  if ( mousePos.x > 100 && mousePos.x < 150) {

    playNotes3();
  }
  if ( mousePos.x > 150 && mousePos.x < 200) {

    playNotes4();
  }
  if ( mousePos.x > 200 && mousePos.x < 250) {

    playNotes5();
  }
  if ( mousePos.x > 250 && mousePos.x < 300) {

    playNotes6();
  }
  if ( mousePos.x > 300 && mousePos.x < 350) {

    playNotes7();
  }
  if ( mousePos.x > 350 && mousePos.x < 400) {

    playNotes8();
  }
  if ( mousePos.x > 400 && mousePos.x <450) {

    playNotes9();
  }
  if ( mousePos.x > 450 && mousePos.x < 500) {

    playNotes10();
  }  


  // draw the waveforms
  for ( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }


  //Drive each color object
  myCol1.drive();
  myCol2.drive();
  myCol3.drive();
  myCol4.drive();
  myCol5.drive();
}

void playNotes1() {


  if (mouseY > 100) {
    println("1");
    out.playNote( 0.1, 0.3, new BumpyInstrument( "A2", 1.8 ) );
    out.playNote( 0.1, 0.3, new BumpyInstrument( "E2", 3.2 ) );
    out.playNote( 0.1, 0.3, new BumpyInstrument( "C2", 1.8 ) );
  } else {
    println("2");
    out.playNote( 0.1, 0.3, new BumpyInstrument( "A2", 1.8 ) );
  }
}
void playNotes2() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A2", 0.8 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "C2", 2.8 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "E2", 1.8 ) );
}
void playNotes3() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A1", 1.2 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "C1", 12.6 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "A1", 0.1 ) );
}
void playNotes4() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A1", 1.2 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "B3", 3.6 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "G1", 2.1 ) );
}
void playNotes5() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A1", 0.6 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "A2", 0.6 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "A2", 0.6 ) );
}
void playNotes6() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A1", 1.2 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "C1", 0.6 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "G1", 0.1 ) );
}
void playNotes7() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A1", 30.0 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "B1", 30.0 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "G1", 20.0 ) );
}
void playNotes8() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A3", 1.3 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "C3", 2.6 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "G3", 0.3 ) );
}
void playNotes9() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A1", 1.2 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "C3", 2.6 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "G1", 0.1 ) );
}
void playNotes10() {

  out.playNote( 0.1, 0.3, new BumpyInstrument( "A1", 1.2 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "C1", 0.6 ) );
  out.playNote( 0.1, 0.3, new BumpyInstrument( "G1", 0.1 ) );
}
//void mouseMoved() {

//  float freq;
//  float band;
//  freq = map(mouseY, height, 0, 75, 500);
//  band =  200;
//}
void mouseMoved()
{
  // map the mouse position to the range [100, 10000], an arbitrary range of passBand frequencies
  float passBand = map(200+mouseY, 0, height, 100, 2000);
  bpf.setFreq(passBand);
  float bandWidth = map(200+mouseY, 0, height, 50, 500);
  bpf.setBandWidth(bandWidth);
  // prints the new values of the coefficients in the console
  //bpf.printCoeff();
}