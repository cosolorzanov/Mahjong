
import remixlab.proscene.*;
import remixlab.dandelion.geom.*;
import remixlab.bias.event.*;
import java.util.*;

Scene scene;
InteractiveFrame f1;
Board b;
PImage img;
int level=0;
Player player;
int minutes=0;
int seconds=0;
int rotate=0;
Date date = new Date();   // given date

color wColor = color(255, 255, 255);
color f1Color = color(255, 0, 0);

void setup() {
  
  size(670, 500,P3D);
  scene = new Scene(this);
  scene.setAxesVisualHint(false); // hide axis
  scene.setGridVisualHint(false); // hide grid
  player= new Player();
  player.setTimeStart(0,0);
  img = loadImage("images/fondo.jpg");  
  b= new Board(-300,-180,600,360);
  b.setLevel(0); 
  b.update();
  scene.setRadius(200);
  scene.showAll();
 
}

void draw() {
  background(0);
  image(img, -300, -180, 600,360);
  setText();
  scene.drawFrames();
  scene.beginScreenDrawing();
  scene.endScreenDrawing();
}

void setText(){
  fill(0, 102, 153);
  textSize(30);
  
  text("Level "+(level+1), -300, -190); 
  
  fill(255);
  textSize(15);
  
  if(!Player.playing){
    text("Press '  ' to change level.", -300, 210);
    text("Press 's' to start.", -300, 195); 
    text("Press 'r' to shuffle board.", -300, 225);
  }
  else
  text("Press 's' to exit.", -300, 195); 
  if (Player.playing)
      if (!b.isEnd())
          player.setTimeNow(new Date().getMinutes(),new Date().getSeconds());
      else{          
          fill(255);
          textSize(35);          
          text(player.toString(), -170, 0); 
          textSize(15);
      }
          
  if (!Player.playing ){
      player.setTimeNow(0,0);
      player.setTimeNow(0,0);
  }
  text("Playing "+player.toString(), 80, 210);

}

void keyPressed() {
  if (key == ' ' && !Player.playing ){
      b.clear();
      level = (level+1)%3;
      b.setLevel(level);      
      b.update();
   }
   
   if( key == 's'){
       b.complete();
       Player.playing=!Player.playing;
       date = new Date();
       if (Player.playing){
           player.setTimeStart(date.getMinutes(), date.getSeconds());
       }
       else{
           player.setTimeStart(0,0);
       }
   }
   if (key == 'r' && !Player.playing ){  
      b.clear();
      b.shuffle();      
      b.update();
   }
}