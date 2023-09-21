import java.awt.*;

PVector target;

PImage screenshot;
Robot robot;

void setup() {
  size(500, 500);
  target = new PVector(0, 0);
  
  try {
    robot = new Robot();
  } catch(Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  if (frameCount % 60 == 0) {
    screenshot();

    if (screenshot != null) {

      for (int i = 0; i < screenshot.width; i++) {
        for (int j = 0; j < screenshot.height; j++) {
          color c = screenshot.get(i, j);

          if (c == color(41, 109, 211)) {
            target = new PVector(i, j);
            break;
          }
        }
      }
    }
  }
  println(target);
  
  //move mouse
  PointerInfo a = MouseInfo.getPointerInfo();
  Point b = a.getLocation();
  int x = (int) b.getX();
  int y = (int) b.getY();
  PVector move = new PVector(target.x-x, target.y-y);
  move.normalize().mult(5);
  robot.mouseMove(x+(int)move.x, y+(int)move.y);
  
  println(x);
}

void screenshot() {
  try {
    screenshot = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
  }
  catch (AWTException e) {
  }
}

void keyPressed(){
  if (key == 'q')
    exit();
}
