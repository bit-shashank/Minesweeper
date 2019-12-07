import java.util.*;


int scale=40;
int rows;
int cols;
Cell grid[][];
int bombs=15;
PImage flagImg;

void setup(){
  size(400,400);
  rows=width/scale;
  cols=height/scale;
  flagImg=loadImage("flag.png");
  grid=new Cell[rows][cols];
  for(int i=0;i<rows;i++){
    for(int j=0;j<cols;j++){
      grid[i][j]=new Cell(i,j);
    }
  }
  plotBombs();
  neighbour();
}
void draw(){
  background(200);
  for(int i=0;i<rows;i++){
    for(int j=0;j<cols;j++){
      grid[i][j].show();
    }
  }

}

void plotBombs(){
  ArrayList<Cell> mat=new ArrayList<Cell>();
  for(int i=0;i<rows;i++){
    for(int j=0;j<cols;j++){
      mat.add(grid[i][j]);
    }
  }
  Collections.shuffle(mat);
  for(int i=0;i<bombs;i++){
    Cell c=mat.get(i);
    c.hasBomb=true;
  }
}

void mousePressed(){
  if(mouseButton==RIGHT){
    int x=mouseX/scale;
    int y=mouseY/scale;
    if(grid[x][y].hasFlag)return;
    if(grid[x][y].hasBomb){
      grid[x][y].revealed=true;
      gameOver();
    }
    else{
      grid[x][y].revealed=true;
      reveal(x,y);
    }
    if(win()){
      draw();
      textSize(60);
      fill(51);
      text("You Won",width/4,height/2);
      noLoop();
    }
  }
 else if(mouseButton==LEFT){
   int x=mouseX/scale;
   int y=mouseY/scale;
   if(!grid[x][y].revealed)
   grid[x][y].hasFlag=!grid[x][y].hasFlag;
 }
}
boolean win(){
  int count=0;
   for(int i=0;i<rows;i++){
    for(int j=0;j<cols;j++){
       if(!grid[i][j].revealed)
       count++;
    }
  }
  return count==bombs;
}
void gameOver(){
  for(int i=0;i<rows;i++){
    for(int j=0;j<cols;j++){
       grid[i][j].revealed=true;
       grid[i][j].hasFlag=false;
    }
  }
}

void reveal(int x,int y){
  if(grid[x][y].value==0){
    grid[x][y].revealed=true;
      for(int xoff=-1;xoff<=1;xoff++){
          for(int yoff=-1;yoff<=1;yoff++){
            int xind=x+xoff;
            int yind=y+yoff;
            if(xind>=0 && xind<rows && yind>=0 && yind<cols){
              if(!grid[xind][yind].hasBomb)
                  if(!grid[xind][yind].revealed){
                     grid[xind][yind].revealed=true;
                    reveal(xind,yind);
                  
                }
              }
          }
        }
  }
}



void neighbour(){
  for(int i=0;i<rows;i++){
    for(int j=0;j<cols;j++){
      if(!grid[i][j].hasBomb){
        
        int bombCount=0;
        for(int xoff=-1;xoff<=1;xoff++){
          for(int yoff=-1;yoff<=1;yoff++){
            int xind=i+xoff;
            int yind=j+yoff;
            if(xind>=0 && xind<rows && yind>=0 && yind<cols){
              if(grid[xind][yind].hasBomb)
                bombCount++;
              }
          }
        }
        grid[i][j].value=bombCount;
      }
    }
  }
}
