/**
  * This sketch demonstrates how to create synthesized sound with Minim using an AudioOutput and
  * an Instrument we define. By using the playNote method you can schedule notes to played 
  * at some point in the future, essentially allowing to you create musical scores with code. 
  * Because they are constructed with code, they can be either deterministic or different every time. 
  * This sketch creates a deterministic score, meaning it is the same every time you run the sketch.
  * <p>
  * For more complex examples of using playNote check out algorithmicCompExample and compositionExample
  * in the Synthesis folder.
  * <p>
  * For more information about Minim and additional features, visit http://code.compartmental.net/minim/
  */

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
PImage background;

// to make an Instrument we must define a class
// that implements the Instrument interface.
class SineInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  
  SineInstrument( float frequency )
  {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
    // start the amplitude envelope
    ampEnv.activate( duration, 0.5f, 0 );
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    wave.unpatch( out );
  }
}

void setup()
{
  size(800, 600, P3D);
  
  background=loadImage("background.jpg");
  
  minim = new Minim(this);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
  // when providing an Instrument, we always specify start time and duration
  out.playNote( 0.0, 0.9, new SineInstrument( 97.99 ) );
  out.playNote( 1.0, 0.9, new SineInstrument( 123.47 ) );
  
  // we can use the Frequency class to create frequencies from pitch names
  out.playNote( 2.0, 2.9, new SineInstrument( Frequency.ofPitch( "C3" ).asHz() ) );
  out.playNote( 3.0, 1.9, new SineInstrument( Frequency.ofPitch( "E3" ).asHz() ) );
  out.playNote( 4.0, 0.9, new SineInstrument( Frequency.ofPitch( "G3" ).asHz() ) );
}

void draw()
{
  background(background);
  stroke(255);
  
  translate(400,200);
  rotate(90);
  // draw the waveforms
  for(int i = 0; i < out.bufferSize() - 550; i++)
  {
    stroke(246,250,137);
    strokeWeight(1.5);
    line( i-300,   out.left.get(i)*30-30, i-299, out.left.get(i+1)*30-30 );
    stroke(85,201,214);
    line( i-300,  out.right.get(i)*30-35, i-299, out.right.get(i+1)*30-35 );
    stroke(237,0,104);
    line( i-300,  out.right.get(i)*30-40, i-299, out.right.get(i+1)*30-40 );
    stroke(250,55,55);
    line( i-300,  out.right.get(i)*30-45, i-299, out.right.get(i+1)*30-45 );
stroke(5,130,210);
    line( i-300,  out.right.get(i)*30-50, i-299, out.right.get(i+1)*30-50 );  
    stroke(230,150,50);
    line( i-300,  out.right.get(i)*30-55, i-299, out.right.get(i+1)*30-55 );
    stroke(100,215,120);
    line( i-300,  out.right.get(i)*30-60, i-299, out.right.get(i+1)*30-60 );
}
  
}