/**
 * This sketch demonstrates how to play a file with Minim using an AudioPlayer. <br />
 * It's also a good example of how to draw the waveform of the audio.
 * <p>
 * For more information about Minim and additional features, 
 * visit http://code.compartmental.net/minim/
 */
//import minim and spacebrew libraries
import ddf.minim.*;
import spacebrew.*;

// Spacebrew stuff
String server = "sandbox.spacebrew.cc";
String name   = "Choice_Audio";
String description   = "Sound_response";

//name JSON object
JSONObject json;

Spacebrew sb;
//name your differnt audio players
Minim minim;
AudioPlayer player;
AudioPlayer horse;
AudioPlayer canary;
AudioPlayer aircraft;
AudioPlayer phone;
AudioPlayer baby;

//sets the choice back to 0
int choice = -1;

void setup()
{
  size(512, 200, P3D);

  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile("sizzle.mp3");
  horse = minim.loadFile("horse.mp3");
  canary = minim.loadFile("canary.mp3");
  aircraft = minim.loadFile("aircraft063.mp3");
  phone = minim.loadFile("1920s phone.mp3");
  baby = minim.loadFile("baby.mp3");

  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );

  // declare your publishers
  sb.addSubscribe( "what_was_your_choice?", "choice" ); 

  // declare your subscribers
//  sb.addSubscribe( "no_subscriber", "choice" );

  // connect!
  sb.connect(server, name, description );
}

void draw()
{
  background(0);
  stroke(255);
  controlSound();
}

//create custom message
void onCustomMessage( String name, String type, String value ) {
  println("name " + name + ", type " + type + ", value "); 

  if (type.equals("choice")) {  
    json = new JSONObject();
    json = JSONObject.parse(value);

    // parse the actual choice number received
    choice = json.getInt("choice");
    println( "received choice: " + choice );

    // generate a random number to add randomness into the mix
    choice = (int) ( choice + random(6) ) % 6 + 1;
    println( "randomize choice: " + choice );

  }
}
    //allow for pausing and for the player to start again
void controlSound() {
  if (choice > 0) {   
    if (player.isPlaying()) {
      player.pause(); 
      player.rewind();
  
    }
    if (horse.isPlaying()) {
      horse.pause(); 
      horse.rewind();
    }
    if (canary.isPlaying()) {
      canary.pause(); 
      canary.rewind();
    }
    if (aircraft.isPlaying()) {
      aircraft.pause(); 
      aircraft.rewind();
    }
    if (phone.isPlaying()) {
      phone.pause(); 
      phone.rewind();
    }
    if (baby.isPlaying()) {
      baby.pause(); 
      baby.rewind();
    }

  //set up if statements for each of the choices made
    // figure out which sound to play
    if (choice == 1) {
      player.play();
      println("one");
    } 
    else if (choice == 2) { 
      horse.play();
      println("two");
    }
    else if (choice == 3) {
      canary.play();
      println("three");
    } 
    else if (choice == 4) {
      aircraft.play();
      println("four");
    }
    else if (choice == 5) {
      phone.play();
      println("five");
    }
    else if (choice == 6) {
      baby.play();
      println("six");
    }        

    // set choice back to -1 now the sounds has been activated
    choice = -1;
  }
}  

