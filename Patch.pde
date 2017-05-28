public class Patch extends InteractiveFrame{
  
  String text;
  float w, h;
  float posx,posy,posz;
  PGraphics pg;
  PImage img;
  int indexi,indexj;
  Board b;
  boolean visible;
  boolean select;
  
  public Patch(float posx, float posy, float w, float h,PImage  img,int indexi,int indexj, Scene scene, Board b){
      super(scene);
      this.posx=posx;
      this.posy=posy;
      this.w=w;
      this.h=h;
      this.img =img;
      this.b=b;
      this.indexi=indexi;
      this.indexj=indexj;
      visible=true;
      select=false;
      posz=0;     
      //pg = createGraphics((int)w,(int)h);
      removeBindings();
      disableVisualHint();
      setHighlightingMode(InteractiveFrame.HighlightingMode.NONE);
      
      setShape("drawPatch");
      setClickBinding(LEFT, 1, "play");         
  }
  
  public void drawPatch(PGraphics pg){
      if(visible){
           int inc=2;
           this.pg=pg;
           pg.pushStyle();
           if (grabsInput()) {     
              pg.fill(200,200,100);
              pg.stroke(200, 200, 100);
              pg.strokeWeight(3);
              pg.rect(posx-inc, posy-inc, w+inc*2, h+inc*2);
              pg.image(img, posx, posy, w, h); 
            } else {
              pg.image(img, posx, posy, w, h);
            }
            
          if(select){
                 pg.fill(200,200,100);
                 pg.stroke(255);
                 pg.strokeWeight(3);
                 pg.rect(posx-inc, posy-inc, w+inc*2, h+inc*2);
                 pg.image(img,  posx-inc, posy-inc, w+inc*2, h+inc*2);           
           }
           else{
                  pg.image(img, posx, posy, w, h);
           }
           pg.popStyle();
      }
  }  
  
  void setSize(float w, float h){
    this.w=w;
    this.h =h;
  } 
  
  void setPos(float posx, float posy){
    this.posx=posx;
    this.posy =posy;
  } 
  
  public void play(ClickEvent event){
          //print("i: "+indexi+", j: "+indexj);
       b.play(indexi,indexj);
  }
  
  public void setSelect(boolean select){
    this.select=select;
    setShape("drawPatch");   
  }
  
  public void setVisible(boolean visible){
      this.visible=visible;
      setShape("drawPatch");
  }
}