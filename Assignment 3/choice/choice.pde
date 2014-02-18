/*
 * Custom Data Type Example - Choice
 *
 *   Make a choice and click one of the buttons. 
 *   Receive a sound which represents a future environment you will find yourself in.
 *   
 * 
 */

import spacebrew.*;
String rec = "";
String choice1 = "";
String choice2 = "";
String choice3 = "";
String choice4 = "";
String choice5 = "";
String choice6 = "";
String server="sandbox.spacebrew.cc";
String name=" choice";
String description ="Client that makes a choice and ..sends and receives a virtual dice roll - a number between 1 and 6.";
PFont font;

Spacebrew sb;

//to make a new json object. you can get and set values inside of this object
JSONObject json;


// Keep track of our current place in the range
float distance1;
float distance2;
float distance3;
float distance4;
float distance5;
float distance6;

void setup() {
  //load your font
font =loadFont("BankGothic-Medium-30.vlw");
  size(350, 170);
  // instantiate the spacebrewConnection variable
  sb = new Spacebrew( this );

  // declare your publishers
  //  sb.addPublish( "make_a_choice", "string"); 
  sb.addPublish( "make_a_choice", "choice", "hello");

  //outgoing.toString()
  // declare your subscribers
  sb.addSubscribe( "what_was_your_choice?", "choice" );

  // connect!
  sb.connect(server, name, description );
  
  //create json object
  json = new JSONObject();

}




void draw() {
  background(255);
  stroke(0);
//create your buttons, calculate width and height and x and y mouse positions
  distance1 = dist(mouseX, mouseY, 50, 46);
  distance2 = dist(mouseX, mouseY, 100, 46);
  distance3 = dist(mouseX, mouseY, 150, 46);
  distance4 = dist(mouseX, mouseY, 200, 46);
  distance5 = dist(mouseX, mouseY, 250, 46);
  distance6 = dist(mouseX, mouseY, 300, 46);
  fill(200, 20, 20);

  ellipse(50, 46, 40, 40);
  ellipse(100, 46, 40, 40);
  ellipse(150, 46, 40, 40);
  ellipse(200, 46, 40, 40);
  ellipse(250, 46, 40, 40);
  ellipse(300, 46, 40, 40);

  fill(0, 0, 255);

  // check location of mouse and update drawing of ellipse if necessary
  if (distance1 < 20) //half size of ellipse
  {
    fill (255, 0, 0);
    ellipse(50, 46, 40, 40);
  }
  else if (distance2 < 20) //half size of ellipse
  {
    fill (255, 0, 0);
    ellipse(100, 46, 40, 40);
  }
  else if (distance3 < 20) //half size of ellipse
  {
    fill (255, 0, 0);
    ellipse(150, 46, 40, 40);
  }
  else if (distance4 < 20) //half size of ellipse
  {
    fill (255, 0, 0);
    ellipse(200, 46, 40, 40);
  }
  else if (distance5 < 20) //half size of ellipse
  {
    fill (255, 0, 0);
    ellipse(250, 46, 40, 40);
  }
  else if (distance6 < 20) //half size of ellipse
  {
    fill (255, 0, 0);
    ellipse(300, 46, 40, 40);
  }
textFont(font, 30);
  text("Click a circle to   ", 35, 100);  
  text("make a choice about", 10, 120);
  text("your future", 70, 140);
}

// when mouse is pressed check if mouse was over a choice circle
void mousePressed() {
  int choice = -1;

  // check if mouse was over a "choice" when mouse was clicked
  if (distance1 < 20) //half size of ellipse
  {
    choice = 1;
  }

  else if (distance2 < 20) //half size of ellipse
  {
    choice = 2;
  }

  else if (distance3 < 20) //half size of ellipse
  {
    choice = 3;
  }

  else if (distance4 < 20) //half size of ellipse
  {
    choice = 4;
  }

  else if (distance5 < 20) //half size of ellipse
  {
    choice = 5;
  }

  else if (distance6 < 20) //half size of ellipse
  {
    choice = 6;
  }

  // if a choice was made then set-up json and send it via spacebrew
  if (choice > 0) {   
    json.setInt("choice", choice);
    sb.send ("make_a_choice", json.toString());
  }  
}

//get json object on custommessage
void onCustomMessage( String name, String type, String value ) {
  JSONObject message = JSONObject.parse( value );
  println("choice received = " + message.getInt("choice") );
}

