import controlP5.ControlFont;
import controlP5.ControlP5;
import processing.core.PApplet;
import processing.core.PFont;

import static processing.core.PConstants.LEFT;
import static processing.core.PConstants.TOP;

/**
 * Gui class to display while the animation is either initialized, paused or has finished.
 *
 * @author Tobias Lahmann
 * Date: 18.04.2018
 */
public class GUI {
  private ControlP5 cp5;

  private int now = 0;
  private float fps = 0;
  private float frameRate = 0;

  /**
   * The constructor creates all needed buttons and stores them in the <pre>controlP5.ControlP5</pre> cp5 variable
   */
  public GUI() {
    PApplet c = SlayIt.canvas;

    // Do not change the font
    PFont pfont = c.loadFont("Roboto-Regular-14.vlw"); // use true/false for smooth/no-smooth
    ControlFont font = new ControlFont(pfont, 14);

    Colors col = new Colors();

    cp5 = new ControlP5(c);
    cp5.addButton("Play")
      .setPosition(c.width/2 - 165, c.height - 73)
      .setSize(230, 48)
      .setFont(font)
      .setColor(col.LIGHT_GREEN)
      .plugTo(c, "playPause");
    cp5.addButton("Zurücksetzen")
      .setPosition(25, c.height - 119)
      .setSize(150, 36)
      .setFont(font)
      .setColor(col.BLUE_GREY)
      .plugTo(c, "initialize");
    cp5.addButton("Exit")
      .setPosition(25, c.height - 73)
      .setSize(150, 48)
      .setFont(font)
      .setColor(col.BLUE_GREY)
      .plugTo(c, "exit");
  }

  /**
   * if the gui is currently shown
   *
   * @return is visible
   */
  public boolean isVisible() {
    return cp5.isVisible();
  }

  /**
   * hides the gui
   */
  public void hide() {
    cp5.hide();
  }

  /**
   * displays the gui
   */
  public void show() {
    cp5.show();
  }

  /**
   * Update method for the debugging information
   *
   * @param time      current time of the song
   * @param framerate current framerate
   */
  public void update(int time, float framerate) {
    now = time;
    frameRate = framerate;
  }

  /**
   * Display method to draw debugging information on the screen
   */
  public void display() {
    int sec = now / 1000, ms = now % 1000;
    float smoothing = 0.95f;
    fps = (fps * smoothing) + (frameRate * (1.0f - smoothing));
    String[] texts = new String[]{"Gdg2 Animation", 
      String.format("Framerate: %.2f", fps) + " f/s", 
      "Song Position: " + sec + ":" + ms};
    textSize(16);
    textAlign(LEFT, TOP);
    fill(0, 0, 0, 160);
    noStroke();
    rect(20, 20, 175, texts.length * 25);
    fill(57, 255, 20);
    for (int i = 0; i < texts.length; i++) {
      text(texts[i], 25, 25 + i * 25);
    }
  }
}