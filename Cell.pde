class Cell{
  int x;
  int y;
  boolean revealed;
  int value;
  boolean hasBomb;
  boolean hasFlag;
  
  public Cell(int x,int y){
    this.x=x;
    this.y=y;
    revealed=false;
    hasFlag=false;
  }
  
  void show(){
    noFill();
    stroke(0);
    rect(x*scale,y*scale,scale,scale);
    if(revealed){
      fill(150);
       rect(x*scale,y*scale,scale,scale);
      if(hasBomb){
        fill(255,0,0);
        noStroke();
        ellipse(x*scale+scale/2,y*scale+scale/2,scale/2,scale/2);
      } 
      else{
        textSize(scale/2);
        fill(0);
        if(value>0){
          switch(value){
            case 1:fill(0,0,255);break;
            case 2:fill(0,255,90);break;
            case 3:fill(255,0,0);break;
            case 4:fill(247,222,25);break;
            case 5:fill(210,25,247);break;
            case 6:fill(255,176,120);break;
            case 7:fill(0,0,0);break;
            case 8:fill(7,240,218);break;
          }
          text(value+"",x*scale+scale/3,y*scale+scale/2);
        }
      }
    }
   if(hasFlag){
     image(flagImg,x*scale+2,y*scale+2,scale-2,scale-2);
   }
  }
}
