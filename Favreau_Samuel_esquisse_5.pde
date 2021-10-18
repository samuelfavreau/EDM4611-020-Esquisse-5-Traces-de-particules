/*
 * Class: EDM4611-020
 * Title: Esquisse 5 - Tracés de particules
 * Autor: Samuel Favreau
 
 * Instructions: -Do a left click to add a static body to the scene.
                 -Do a right click to remove a static body to the scene.
                 -Do a middle click to add a body following the mouse.
                 -Press the Enter keys to save the frame.
 */

//Librairies
import processing.pdf.*;
boolean canRecord = false;
boolean recording = false;

//Global variables
ArrayList<Mobile> mobile = new ArrayList();

ArrayList<Static> stat = new ArrayList();
int followIndex;

int mTimer;

color hue;

//----------------------------------------------------------------------------------
//                                    SETUP
//----------------------------------------------------------------------------------

void setup() {
  //Size of the canvas
  size(800, 800);
  
  //Sets the color mode to HSB
  colorMode(HSB, 360, 100, 100);
  //Picks a random hue for the global color
  hue = int(random(360));
}

//----------------------------------------------------------------------------------
//                                    DRAW
//----------------------------------------------------------------------------------

void draw() {
  //Checks if the program can record the frame
  if(canRecord){
    recording = true;
    beginRecord(PDF, "export/frame-####.pdf");
  }
  
  //Refreshes every frame
  background(0);

  //Adds 4 new mobiles every frame
  for (int i = 0; i < 4; i++) {
    mobile.add(new Mobile());
  }

  //Checks every mobiles
  for (int i = mobile.size() - 1; i >= 0; i--) {
    //Displays the mobile
    mobile.get(i).display();

    //Makes the mobile bounce if it touches a static
    for (int j = stat.size() - 1; j >= 0; j--) {
      if (mobile.get(i).collision(stat.get(j))) {
        mobile.get(i).bounce(stat.get(j));
      }
    }
    
    //Updates the position of the mobile
    mobile.get(i).update();

    //Removes the mobile if it exits the screen
    if (mobile.get(i).getLastChild().y >= height + 30 || mobile.get(i).getLastChild().x < -30 || mobile.get(i).getLastChild().x > width + 30) {
      mobile.remove(i);
    }
  }

  //Checks every static
  for (int i = stat.size() - 1; i >= 0; i--) {
    //Displays and updates the static
    stat.get(i).display();
    stat.get(i).update();

    //Makes the static follow the mouse if it's following variable is true
    if (stat.get(i).following) {
      stat.get(i).setPosition(mouseX, mouseY);
    }
    
    //Remove the static if it's exit animation is over
    if (stat.get(i).remove == true) {
      stat.remove(i);
    }
  }
  
  //End the recording if it was in function
  if(canRecord){
    endRecord();
    canRecord = false;
    recording = false;
    println("frame-" + nf(frameCount, 4) +" saved");
  }
}

//----------------------------------------------------------------------------------
//                                    FUNCTIONS
//----------------------------------------------------------------------------------

void mousePressed() {
  //Adds a new static on a left click
  if (mouseButton == LEFT) {
    stat.add(new Static(mouseX, mouseY));
    stat.get(stat.size() - 1).state = IN;
  }

  //Removes the static on a right click
  if (mouseButton == RIGHT) {
    for (int i = 0; i < stat.size(); i++) {
      if (dist(mouseX, mouseY, stat.get(i).p.x, stat.get(i).p.y) <= stat.get(i).size/2 && !stat.get(i).following) {
        stat.get(i).state = OUT;
      }
    }
  }
  
  //Adds a static following the mouse on a middle click
  if (mouseButton == CENTER) {
    stat.add(new Static(mouseX, mouseY));
    stat.get(stat.size() - 1).state = IN;
    stat.get(stat.size() - 1).following = true;
  }
}

void mouseReleased() {
  //Removes the following static when the middle mouse button is released
  if (mouseButton == CENTER) {
    for (int i = 0; i < stat.size(); i++) {
      if (stat.get(i).following) {
        stat.get(i).state = OUT;
      }
    }
  }
}

void keyPressed(){
  //Records a new frame when the ENTER key is pressed
  if(keyCode == ENTER){
    canRecord = true;
  }
}
