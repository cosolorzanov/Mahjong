import java.util.Random;
import java.util.Arrays;

public class Board {
  int x,y; //position board
  float w,h; //dimension board
  int n,m; //Board n x m
  float wpatch,hpatch;
  int level; // 3 levels
  PImage images [];
  private Patch[][] patches; // patches that make up the board
  private Patch firstClick= null;
  private Patch secondClick= null;
  
  public Board(int x, int y, int w, int h){      
      this.w=w;
      this.h=h;      
      this.x=x;
      this.y=y;
  }
  
  public void setLevel(int level){
      this.level=level;
      if (level == 0){this.n=3;this.m=6;}
      if (level == 1){this.n=5;this.m=8;}
      if (level == 2){this.n=8;this.m=11;}
      init();      
  }
  
  public void init(){
      this.wpatch = w/m;
      this.hpatch = h/n;
      patches = new Patch[n][m];
      images= new PImage[n*m];      
      for(int i=0;i<(n*m)/2;i++){    
           images[i] =loadImage("images/"+(i+1)+".jpg");        
           //images[i+n*m/2] =loadImage("images/"+(i+1)+".jpg");
           images[i+n*m/2]=images[i];
      }
      shuffle();      
  }
  
  public void shuffle(){
      shuffleArray(images);
  }
  
  public void update( ){      
      int index;
      for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            index=i*m+j;           
            patches[i][j] = new Patch(x+(j*wpatch),y+(i*hpatch),wpatch,hpatch,images[index],i,j,scene,this);
        }      
      }
  }
  void clear(){
      for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            if(patches[i][j]!=null)
                patches[i][j].setVisible(false);
        }      
      }
  }
  
  void complete(){
      for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            if(patches[i][j]!=null)
                patches[i][j].setVisible(true);
        }      
      }
  }
  
  boolean isEnd(){
      for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            if(patches[i][j].visible)
                return false;
        }      
      }
      return true;
  }
  
  void play(int indexi,int indexj){
    if(Player.playing){
      if(firstClick==null){
        firstClick= patches[indexi][indexj];
        firstClick.setSelect(true);
      }
      else
      if(firstClick!=null){
          if(secondClick==null){
              secondClick= patches[indexi][indexj];
              secondClick.setSelect(true);
          }          
      }
      
      if(firstClick !=null && secondClick !=null){
          //println(firstClick.indexi+"  "+firstClick.indexj+" "+secondClick.indexi+"  "+secondClick.indexj);
          //equals patch, no images
          if(firstClick.indexi == secondClick.indexi && firstClick.indexj == secondClick.indexj){
              firstClick.setSelect(false);
              secondClick.setSelect(false);
              firstClick=null;
              secondClick=null; 
          }
          //no equals patch, no images
          else{
              firstClick.setSelect(false);
              secondClick.setSelect(false);
              
              //equals images
              if(firstClick.img.equals(secondClick.img)){                
                  //println("iguales");
                  firstClick.setVisible(false);
                  secondClick.setVisible(false);
                  firstClick=null;
                  secondClick=null;
              }
              else{
                firstClick=null;
                secondClick=null;                
              }
          }
        }  
    }
  }
  
  void shuffleArray(Object[] array) {
    Random rng = new Random();    
    for (int i = array.length; i > 1; i--) {
      int j = rng.nextInt(i);  // 0 <= j <= i-1 (0-based array)
      Object tmp = array[j];
      array[j] = array[i-1];
      array[i-1] = tmp;
    }
  }
}

static class Player{
  static boolean playing;
  int minutesn,secondsn;
  int minutess,secondss;
  
  public Player(){  
  }
  
  public void setTimeNow(int minutesn, int secondsn){
     this. minutesn=minutesn;
     this.secondsn=secondsn;
  }
  public void setTimeStart(int minutess, int secondss){
     this. minutess=minutess;
     this.secondss=secondss;
  }
  
  @Override
  String toString(){
    int sn = minutesn*60+secondsn;
    int ss = minutess*60+secondss;
    int dif = sn-ss;
    int m = dif / 60;
    int s = dif % 60;
    return m +" minutes "+ s + " seconds.";
  }
}