
// MonsterDraw v1.0!

// Import Minim to use audio
import ddf.minim.*; 


// Variables that will recive function calls:

int screenColorHandler = 0; // These four ints check for a change in the value
int screenClearHandler = 0; // From the default, letting you treat an int return
int soundToggleHandler = 0; // Pretty much as a bool by looking for a value change.
int screenShotHandler = 0;

// Raw variables
int output = 1; // draw tool selector
int modeToggle = 1; // HSB assoication mode selector
color screenColor = 400; // Background color settings


// constraint stuff for resizing draw area... these names aren't the best and are legacy to an
// older mockup. Think of border as X-border and bottomBorder as Y-border.
int border, bottomBorder;

// for drawing plain black/white line - I just made this esentally a 2 state enumeration with
// a bool so that the stroke settings for other things weren't messed with by going into
// black/white pen mode.
boolean colorless = false;

// Tracks what image should be used for the camera eye
boolean photoTaken = false; // this lets the counter for the flash button turn on/off
int counter = 0; // the counter for the flash button.

// master control for the sound.
boolean soundOn = true;

// GUI frame variable
PImage frame;

// Declaring the class variables for buttons I made. Please note that class names
// should properly be cammelcased with the first leter of both the first and following
// words in caps as below.

// Rectangle buttons:
RectButton backgroundButton; // deals with next background color.
RectButton clearButton; // Deals with clearing the screen.
RectButton colorButton; // Changes the HSB assoication.
RectButton brushButton; // Changes the brush being used.

// Circle Buttons:
CircleButton exitButton; // to exit() app.
CircleButton soundButton; // turns sound on and off. 
CircleButton screenShotButton; // takes a screen shot.
CircleButton screenShotTaken;

// declare a Minim variable.
Minim minim;

// Use an audio player for the intro sound it plays when it starts up.
AudioPlayer startUp;

void setup() 
{
  // Android orientation lock.
  orientation(LANDSCAPE);
  
  // All the basic setup stuff.
  size(1280,720);
  colorMode(HSB, 400);
  background(screenColor);
  
  //Center all the modes. I still feel this should be the default.
  imageMode(CENTER);
  rectMode(CENTER); 
  ellipseMode(CENTER); 
  
  // Feel like this should be the default too.
  smooth();
  
  // Constraint variables put them here so that width and height are already defined.
  border = int(width * 0.171875);// makes part of the area not useable
  bottomBorder = (height / 6); // makes more of the area not useable
  
  // get minim up and running.
  minim = new Minim(this);
  
  // load the startup sound
  startUp = minim.loadFile("sounds/OpenSound.wav");
  
  // Load the Gui Frame
  frame = loadImage("MonsterApp2.png");
  
  // Load button objects here.
  // RectButtons:
  // Final Placements: backgroundButton: Done, clearButton: Done, colorButton: Done, brush button: Done
  // varname = new RectButton(X,Y, W, H, Image, frames, Sound)
  backgroundButton = new RectButton((int(width - (width * 0.0859375))), (int(height / 1.463)), (int(width / 12.8)), (int(width / 12.8)), "spritestrips/BackgroundStrip.png", 2, "sounds/BackgroundButtonSound.wav");
  clearButton = new RectButton((int(width - (width * 0.08517))), (int(height / 1.217)), (int(height / 12)), (int(height / 12)), "spritestrips/ClearStrip.png", 2, "sounds/ClearButtonSound.wav");
  colorButton = new RectButton((int(width - (width * 0.0859375))), (int(height * 0.518)), (int(width / 12.8)), (int(width / 12.8)), "spritestrips/ColorStrip.png", 6, "sounds/ColorButtonSound.wav");
  brushButton = new RectButton((int(width - (width * 0.0859375))), (int(height / 2.83)), (int(width / 12.8)), (int(width / 12.8)), "spritestrips/BrushStrip.png", 9, "sounds/BrushButtonSound.wav");
  
  // CircleButtons:
  // Final Placements: exitButton: Done soundButton: Done screenShootButton: Done?
  // varname = new CircleButton(X, Y, R, Image, frames, Sound)
  exitButton = new CircleButton((int(width * 0.05078)), (int(height * 0.9125)),(int(0.0219 * width)), "spritestrips/ExitStrip.png", 2, "sounds/ExitButtonSound.wav");
  soundButton = new CircleButton((int(width / 16)), (int(height / 9)), (int(height / 11.8)), "spritestrips/SoundStrip.png", 2, "sounds/SoundButtonSound.wav");
  screenShotButton = new CircleButton((int(width - (width / 15.8))), (int(height / 9)), (int(height / 11.8)), "spritestrips/CameraStrip.png", 2, "sounds/CameraButtonSound.wav");
  screenShotTaken = new CircleButton((int(width - (width / 15.8))), (int(height / 9)), (int(height / 11.8)), "spritestrips/PhotoTaken.png", 1, "sounds/CameraButtonSound.wav");
  
  // Finish off startup with a nice opening roar! =)
  startUp.play();
}

void draw()
{
  // draw method calls from button classes. These are what makes the buttons draw themselves.
  backgroundButton.display();
  clearButton.display();
  colorButton.display();
  brushButton.display();
  exitButton.display();
  soundButton.display();
  
  // This helper function uses a dummy second button call to overwrite the take screen shot
  // button with a screen shot taken button for a set number of calls to the draw() method.
  photoIcon();
  
  // GUI Frame Draw:
  image(frame, (width/2), (height/2));
  
}

void mouseDragged() 
{
  
  // There's a lot of locals for mouseDragged() as it will be handinding the majority of the
  // user input. I call off of the variables with the names "start<foo>" because as you mode
  // swap they will be associated with different parts of the HSB interface.
  float startHue = map(mouseX, 0, width, 0, 400); // mapped to half of screen width
  float startSaturation = map(mouseY, 0, height, 0, 400); // mapped to half of screen height
  float speed = dist(pmouseX, pmouseY, mouseX, mouseY); //need this to be mapped for speed.
  float startBrightness = map(speed, 0, 10, 0, 400);
  
  // this is for the tools that alter the width of the line drawing
  float StartLineWeight = map(speed, 0, 10, 0, 10);
  StartLineWeight = constrain(StartLineWeight, 0, 10);
  
  // The outer if statement deals with if it's drawing with simple black/white lines or not.
  if (colorless == false)
  {
    
   // this logic deals with the associations between the three parts of the HSB color mode
   // and the mouse input types. I had to include the logic here because otherwise it was
   // giving me big cows about things not existing.
   if (modeToggle == 1)
     {
       stroke(startHue, startSaturation, startBrightness);
     }
   if (modeToggle == 2)
     {
       stroke(startBrightness, startHue, startSaturation);
     }
   if (modeToggle == 3)
     {
       stroke(startSaturation, startBrightness, startHue);
     }
   if (modeToggle == 4)
     {
       stroke(startHue, startBrightness, startSaturation);
     }
   if (modeToggle == 5)
     {
       stroke(startBrightness, startSaturation, startHue);
     }
   if (modeToggle == 6)
     {
       stroke(startSaturation, startBrightness, startHue);
     }
    
  strokeWeight(StartLineWeight);
  }
  
  // determines the color based on the background color of the screen.
  if (colorless == true)
  {
    if (screenColor == 0)
    {
      stroke(400);
    }
    if (screenColor == 400)
    {
      stroke(0);
    }
  }
  
  // This calls the function toolPicker, which handles all the associations between how the 
  // sketch draws things and the mouseDragged function.
  toolPicker();
}


// The mousepressed here is for testing modes 
void mousePressed()
{
  // only checks if press outside draw area to reduce needless calls.
  if (!(mouseX > (border) && mouseX < (width - (border ))
      && mouseY > (bottomBorder) && mouseY < (height - (bottomBorder)) &&
      pmouseX > (border) && pmouseX < (width - (border))
      && pmouseY > (bottomBorder) && pmouseY < (height - (bottomBorder))))
      {
        // place returns in intigers to allow for more then one check on the call with out
        // triggering any unexpected results.
        int backgroundReturn = backgroundButton.click();
        int clearReturn = clearButton.click();
        int colorReturn = colorButton.click();
        int brushReturn = brushButton.click();
        int exitReturn = exitButton.click();
        int soundReturn = soundButton.click();
        int screenShotReturn = screenShotButton.click();
        
        
        // Dealing with clear screen logic:
        // if the return from clearButton doesn't match the last known value... clear screen.
        if (clearReturn != screenClearHandler)
        {
          // Update the screen clear handler
          screenClearHandler = clearReturn;
          
          //update 
          background(screenColor);
         
        }
        
        // Dealing with background color logic:
        // if the return from backgroundButton doesn't match the last known value... change background color.
        if (backgroundReturn != screenColorHandler)
        {
          // Update the background color handler.
          screenColorHandler = backgroundReturn;
         
          // changes the background colors around. 
          if (screenColor == 400)
          {
            screenColor = 0;
          }
          else
          {
            screenColor = 400;
            
          }
          background(screenColor);
        }
        
        // Set the color mode. Has a constraint for now because of mockup buttons I have access too. can replace
        // with update inside the logic when that's taken care of.
        if (colorReturn <6)
        {
          // updates modeToggle
          modeToggle = (colorReturn + 1);
        }
        
        // Dealing with exit logic. If the button is pressed... exit.
        if (exitReturn != 0)
        {
          // Exits the app
          exit();
        }
        
        // Set the draw mode. Thanks to the toolPicker() function, I don't have to do a lot here.
        output = (brushReturn + 1);
        
        // Deals with the sound being on or off.
        if (soundReturn != soundToggleHandler)
        {
          // Flips the bool to the alternate state
          soundOn = !(soundOn);
          // updates soundToggleHandler
          soundToggleHandler = soundReturn;
        }
        
        // Takes care of screen shots being taken.
        if (screenShotReturn != screenShotHandler)
        {
          // update flag for the graphic for the camera button:
          // my button class wasn't made with consderation of how the camera button 
          // should work. So I had to do some vodo here to make it update based on 
          // time progression rather than what click has occured last.
          photoTaken = true;
          
          // updates screenShotHandler
          screenShotHandler = screenShotReturn;
          
          // defines the photo area.
          int rightBorder = width -  (2 * border);
          int lowerBorder = height - (2 * bottomBorder);
          
          // makes the new image
          PImage screenSave = get(border, bottomBorder, rightBorder, lowerBorder);
          
          // saves it to file
          screenSave.save(""+ year() + "-" + month() + "-" + day() + " " + hour() + "." + minute() + "." +  second() + ".jpg");
          
 
        }
        

      }
      

}
   
