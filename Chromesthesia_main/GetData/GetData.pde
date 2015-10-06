import oscP5.*;
import netP5.*;

import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;



float locx;
float locy;

float gotFloat1;
float gotFloat2;
float gotFloat3;

int n = 110;
float[][] magnets = new float[n][n];
float[][] forces = new float[n][n];
int time = 0;
int scale = 12;


PVector mousePos;
float inc;


OscP5 oscP5Location1;
NetAddress location2;

Minim minim;
AudioOutput out;
BandPass   bpf;

Oscil fm;
Oscil am;

PImage img;


void setup() {
  size( displayWidth, displayHeight, P3D );

  img = loadImage("chroma.png");

  oscP5Location1 = new OscP5(this, 5001);
  location2 = new NetAddress("127.0.0.1", 6001);

  // initialize the minim and out objects
  minim = new Minim( this );
  out   = minim.getLineOut();

  // make the Oscil we will hear.
  // arguments are frequency, amplitude, and waveform

  Oscil wave = new Oscil( 200, 0.4, Waves.SINE );
  //Oscil wave2 = new Oscil( 200, 0.4, Waves.SINE );

  // make the Oscil we will use to modulate the frequency of wave.
  // the frequency of this Oscil will determine how quickly the
  // frequency of wave changes and the amplitude determines how much.
  // since we are using the output of fm directly to set the frequency 
  // of wave, you can think of the amplitude as being expressed in Hz.
  
  fm   = new Oscil( 10, 2, Waves.SINE );
  //am   = new Oscil( 10, 2, Waves.SINE );
  // set the offset of fm so that it generates values centered around 200 Hz
  
  // the lower the numbet the derp the sound 
  
  fm.offset.setLastValue( 100 );
  //am.offset.setLastValue( 100 );
  // patch it to the frequency of wave so it controls it
  fm.patch( wave.frequency );
  //am.patch( wave.frequency );
  // and patch wave to the output
  wave.patch( out );
  //wave2.patch( out );

  int sx = 180*scale;
  int sy = 180*scale;
  //size(sx,sy);
  background(255);
  strokeWeight(2*scale);

  mousePos = new PVector (mouseX, mouseY);
  bpf = new BandPass(440, 20, out.sampleRate());
  out.addEffect(bpf);
}


void oscEvent(OscMessage theOscMessage) {  
  String incomingHeader = theOscMessage.get(0).stringValue();
  int incomingMouseX = theOscMessage.get(1).intValue();
  int incomingMouseY = theOscMessage.get(2).intValue();
  float incomingFloat1 = theOscMessage.get(3).floatValue();
  float incomingFloat2 = theOscMessage.get(4).floatValue();
  float incomingFloat3 = theOscMessage.get(5).floatValue();


  locx = incomingMouseX;
  locy = incomingMouseY;

  gotFloat1 = incomingFloat1;
  gotFloat2 = incomingFloat2;
  gotFloat3 = incomingFloat3;
}


void draw() {

  int one = 10;
  int two = 30;
  int three = 40;

  if(gotFloat1 > gotFloat2 && gotFloat1 > gotFloat3){
  // println("one is the biggest");
   gotFloat1 = gotFloat1;
  }else{
   println("one is Small");
   gotFloat1 = gotFloat1/2; 
  }

  if(gotFloat2 > gotFloat1 && gotFloat2 > gotFloat3){
  //  println("one is the biggest");
   gotFloat2 = gotFloat2;
  }else{
  // println("one is Small");
   gotFloat2 = gotFloat2/2; 
  }

   if(gotFloat3 > gotFloat1 && gotFloat3 > gotFloat2){
   println("one is the biggest");
   gotFloat3 = gotFloat3;
  }else{
   println("one is Small");
   gotFloat3 = gotFloat3/2; 
  }




  println("new value of one " + one);

  background(gotFloat1*2, gotFloat2*2, gotFloat3*2);

  stroke( 255);

  //println(frameRate);
  mousePos.x = mouseX;




  stroke( 255 );
  // draw the waveforms
  //for( int i = 0; i < out.bufferSize() - 1; i++ )
  //{
  // // find the x position of each buffer value
  // float x1  =  map( i, 0, out.bufferSize(), 0, width );
  // float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
  // // draw a line from one buffer position to the next for both channels
  // line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
  // line( x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  //}  

  //text( "Modulation frequency: " + fm.frequency.getLastValue(), 5, 15 );
  //text( "Modulation amplitude: " + fm.amplitude.getLastValue(), 5, 30 );

  //float modulateAmount = map( gotFloat1, 0, height, 220, 1 );
  //float modulateFrequency = map( gotFloat2, 0, width, 0.1, 100 );

  //fm.setFrequency( modulateFrequency );
  //fm.setAmplitude( modulateAmount );








  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      //forces[i][j] = 0.0;
      forces[i][j] = 1*(noise(0.1*i, 0.1*j, 0.01*time)-0.5);  
    }
  }
  //background(255);
  fill(0, 100);
  rect(0, 0, width, height);
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      pushMatrix();
      translate(1*scale*i, 0.6*scale*j);

      strokeWeight(3);
      stroke(50*(abs(magnets[i][j]) % 3.12), 20, 200, 255);

      line(1*scale, 0, 0, 0);

      if (abs(magnets[i][j]) % 3.12 < 0.5) {
        //main color
        stroke(255);
        line(1*scale, 25+out.left.get(i)*70, 0, 0);
      }


      if (i<9) {
        forces[i][j] -= magnets[i][j] - magnets[i+1][j];
      }
      if (i>0) {
        forces[i][j] -= magnets[i][j] - magnets[i-1][j];
      }
      if (j<9) {
        forces[i][j] -= magnets[i][j] - magnets[i][j+1];
      }
      if (j>0) {
        forces[i][j] -= magnets[i][j] - magnets[i][j-1];
      }

      magnets[i][j] += 0.2*forces[i][j];

      popMatrix();
    }
  }
  time=time+1;
  
  println("mouseX " + mouseX + "col " + gotFloat1*10);
  
//  map the mouse position to the range [100, 10000], an arbitrary range of passBand frequencies


  float passBand = map(gotFloat2, 0, height, 10, 2200);
  bpf.setFreq(passBand);
  
  float bandWidth = map(gotFloat2, 0, height, 50, 600);
  bpf.setBandWidth(bandWidth);



   float modulateAmount = map( gotFloat1*10, 0, height, 220, 1 );
  float modulateFrequency = map( gotFloat2*10, 0, width, 0.1, 100 );
  
  


  fm.setFrequency( modulateFrequency );
  fm.setAmplitude( modulateAmount );


  //am.setFrequency( modulateFrequency2 );
  //am.setAmplitude( modulateAmount2 );
}


void mouseMoved()
{

}

void mousePressed() {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      magnets[i][j] = random(-10, 10);
    }
  }
}