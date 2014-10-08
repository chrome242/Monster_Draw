void toolPicker() 
// Deals with handling what tool is being used to draw. I could have done this with iteration
// if I were less lazy, but at least I've got it all in one spot in this function here.


{
  // This logic constrains the draw to within the bordered area. 
  if (mouseX > border && mouseX < (width - border)
    && mouseY > bottomBorder && mouseY < (height - bottomBorder) &&
    pmouseX > border && pmouseX < (width - border)
    && pmouseY > bottomBorder && pmouseY < (height - bottomBorder))
  {
      
    if (output == 1) 
    {
      // This is a basic colored line, colors determined by the color mode.
      tool1(mouseX, mouseY, pmouseX, pmouseY);
      
      // Turns off corlorless mode, if active.
      if (colorless == true)
      {
        colorless = false;
      }
      
    }
    
    if (output == 2) 
    {
      // This is a line that changes size based on the mapped value in mouseDragged()
      tool2(mouseX, mouseY, pmouseX, pmouseY);
      
      // Turns off corlorless mode, if active.
      if (colorless == true)
      {
        colorless = false;
      }
    }
    
    if (output == 3) 
    {
      // This is a line this is simple black or white, based on screen color.
      tool1(mouseX, mouseY, pmouseX, pmouseY);
      colorless = true;   
    }
    
    if (output == 4) 
    {
      // This tool draws squares that follow the mouse around closely
      tool4(mouseX, mouseY, pmouseX, pmouseY);
      
      // Turns off corlorless mode, if active.
      if (colorless == true)
      {
        colorless = false;
      } 
    }
    
    if (output == 5) 
    {
      // This tool draws circles that follow the mouse around closely
      tool5(mouseX, mouseY, pmouseX, pmouseY);
      
      // Turns off corlorless mode, if active.
      if (colorless == true)
      {
        colorless = false;
      }
    }
    
    if (output == 6) 
    {
      // This tool causes symmetry across both the x and the y axis.
      tool6(mouseX, mouseY, pmouseX, pmouseY);
      
      // Turns off corlorless mode, if active.
      if (colorless == true)
      {
        colorless = false;
      }
    }
    
    if (output == 7) 
    {
      // This tool copies all output along the X axis.
      tool7(mouseX, mouseY, pmouseX, pmouseY);
      
      // Turns off corlorless mode, if active.
      if (colorless == true)
      {
        colorless = false;
      }
    }
    
    if (output == 8) 
    {
      // This tool copies all output along the Y axis.
      tool8(mouseX, mouseY, pmouseX, pmouseY);
      
      // Turns off corlorless mode, if active.
      if (colorless == true)
      {
        colorless = false;
      }
    }
    
    if (output == 9) 
    {
      // This tool is like tool 6, but with a very fine stroke set.
      // Is a very good tool for drawing details over rapid strokes,
      // which come out nicely if the contrast on speed is set to something nice.
      tool9(mouseX, mouseY, pmouseX, pmouseY);
      
      // Turns off corlorless mode, if active.
      if (colorless == true)
      {
        colorless = false;
      }
    
    }
  }

}
  
void photoIcon() {
  // This function decides which image to draw for the screenshot icon on the
  // application, based on the state of the photoTaken bool. it uses a counter that
  // it updates once per call to the function, which is itself called once per
  // draw() refresh, so it in essence is a way of useing the draw as a timer to show 
  // the 'flash' version of the camera icon. 
  
  // This tells the program what to do if the counter is above the max amount I 
  // decidided on for a pause. In this case, it will set the photoTaken Bool to
  // false, and reset the counter.
  if (counter > 40)
  {
    photoTaken = false;
    counter = 0;
  }
  
  // what to do if the bool is true and the counter is less then 0 -
  // which is display the dummy button icon for the 'flash' camera
  // and incriment the counter once per call.
  if (photoTaken == true)
  {
    screenShotTaken.display();
    counter += 1;
  }
  
  // what to do if the bool is false. This is pretty much what should be considered the default.
  if (photoTaken == false)
  {
     screenShotButton.display();
  }
}
