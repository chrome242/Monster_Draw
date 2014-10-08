// Tool functions- These functions all have different instructions for 
// how to draw when the mouse button is depressed and the mouse moved.
// please play with them plenty!! =) Check the descriptions in the
// tool picker function to see what each one does! =)
void tool1(float x,float y, float px, float py) 
{
  strokeWeight(5);
  line(px, py, x, y);
  return;
}

void tool2(float x,float y, float px, float py) 
{
  line(px, py, x, y);
  return;
}

void tool4(float x,float y, float px, float py) 
{
  float randomX = random(25);
  float randomY = random(25);
  pushMatrix();
  translate(x,y);
  rotate(random(py));
  
  // This constraining allows occassional drawing outside of the draw area.
  // However, a tighter contrain would have either required not being able to
  // use a large portion of the draw area for this tool or would require a lot
  // of logic that I don't have time for in the score of getting this project
  // done.
  if (mouseX > (border + 20) && mouseX < (width - (border + 20))
    && mouseY > (bottomBorder + 20) && mouseY < (height - (bottomBorder + 20)) &&
    pmouseX > (border + 20) && pmouseX < (width - (border + 20))
    && pmouseY > (bottomBorder + 20) && pmouseY < (height - (bottomBorder +20)))
   { 
    rect(0 +randomX, 0 +randomY, 8, 8); 
   }
  popMatrix();
  return;
}


void tool5(float x,float y, float px, float py) 
{
  float randomX = random(25);
  float randomY = random(25);
  pushMatrix();
  translate(x,y);
  rotate(random(py));
  
  // This constraining allows occassional drawing outside of the draw area.
  // However, a tighter contrain would have either required not being able to
  // use a large portion of the draw area for this tool or would require a lot
  // of logic that I don't have time for in the score of getting this project
  // done.
  if (mouseX > (border + 20) && mouseX < (width - (border + 20))
    && mouseY > (bottomBorder + 20) && mouseY < (height - (bottomBorder + 20)) &&
    pmouseX > (border + 20) && pmouseX < (width - (border + 20))
    && pmouseY > (bottomBorder + 20) && pmouseY < (height - (bottomBorder +20)))
   { 
    ellipse(0+random(25),0+random(25),8,8);
   } 
  popMatrix();
  return;
}

void tool6(float x,float y, float px, float py)
{
  line(px,py,x,y);
  line(width/2+((width/2)-px),py,width/2+((width/2)-x),y);
  line(px,height/2+((height/2)-py),x,height/2+((height/2)-y));
  line(width/2+((width/2)-px),height/2+((height/2)-py),width/2+((width/2)-x),height/2+((height/2)-y));
  return;
}

void tool7(float x,float y, float px, float py)
{
  line(px, py, x, y);
  line((width / 2 + ((width / 2) -px)),py,( width / 2 + ((width/2)-x)),y);
  return;
}

void tool8(float x, float y, float px, float py) 
{
  line(px, py, x, y);
  line(px, ((height -bottomBorder) / 2 + ((height / 2)- py)), x, ( (height -bottomBorder) /2 + ((height / 2)- y)));
  return;
}

void tool9(float x,float y, float px, float py)
{
  strokeWeight(1);
  line(px,py,x,y);
  line(width/2+((width/2)-px),py,width/2+((width/2)-x),y);
  line(px,height/2+((height/2)-py),x,height/2+((height/2)-y));
  line(width/2+((width/2)-px),height/2+((height/2)-py),width/2+((width/2)-x),height/2+((height/2)-y));
  return;
}

