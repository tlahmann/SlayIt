import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import controlP5.*;

import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

public static AniStates state = AniStates.READY;
private static DevStates devState = DevStates.DEPLOY; // Development state, can eitehr be DEBUG or DEPLOY

public static PApplet canvas;
private Player player;
FFT fft;
private GUI gui;
private final String SONG = "Cryptex_Slay_It_HQ.mp3";

private Dodecahedron dode;
private Laser pew;
private ArrayList<Dodecahedron> dodes = new ArrayList<Dodecahedron>();

void settings() {
  size(1920, 1080, P3D);
  fullScreen(2);
}

void setup() {
  canvas = this;
  frameRate(60);
  surface.setResizable(true);
  player = new Player(SONG);
  gui = new GUI();

  Ani.init(this);

  fft = new FFT( player.song().bufferSize(), player.song().sampleRate() );

  //loadColors(0);
  initialize();
}

void draw() {
  background(0);

  fft.forward( player.song().mix );

  dode.update(player.song().position());
  for (int i = 0; i < 5; i++) {
    dode.spike(i, fft.getBand(i*20) * 5);
    dode.spike(i+5, fft.getBand(i*20) * 5);
    dode.spike(i+10, fft.getBand(i*20) * 5);
    dode.spike(i+15, fft.getBand(i*20) * 5);
    text(i*20 + " : " +fft.getBand(i*20) * 5, 30, 30 + i*25);
  }
  dode.display();

  for (int i = dodes.size()-1; i>=0; i--) {
    Dodecahedron d = dodes.get(i);
    d.update(player.song().position());
    d.display();
    if (d.position.z < -10000) {
      dodes.remove(i);
    }
  }

  pew.update(player.song().position());
  pew.display();

  noStroke();
  fill(0);
  beginShape();
  vertex(-1000, -1000, -1000);
  vertex(width+1000, -1000, -1000);
  vertex(width+1000, height+1000, -1000);
  vertex(-1000, height+1000, -1000);
  endShape(CLOSE);

  // =====
  // Utility procedure, do not change unless you need to. Put all your drawing logic above
  // =====

  /* At the end of the animation the gui should be displayed. For this we'll check if the song is just about half
   a second away from the end*/
  if (Math.abs(player.song().length() - player.song().position()) < 500 && state == AniStates.RUNNING) {
    state = AniStates.READY;
  }
  /* If the animation is running we need to check if the gui is visible. If the animation is not running we
   want to show the gui at all times */
  if (state == AniStates.RUNNING) {
    if (gui.isVisible()) gui.hide();
  } else {
    if (!gui.isVisible()) gui.show();
  }
  // This is the last line of the draw method, because it should always be rendered last (on top)
  if (devState == DevStates.DEBUG) {
    gui.update(player.song().position(), frameRate);
    gui.display();
  }
}

/**
 * Init method. Called when the animation is loaded or when the reset button is pressed.
 * Do not change the visibility, because the gui relies on it being 'public'
 */
public void initialize() {
  player.song().rewind();
  player.song().pause();
  dode = new Dodecahedron();
  dode.position = new PVector(width/2, height/2, 0);
  dode.importAnimation();
  dodes = new ArrayList<Dodecahedron>();
  pew = new Laser();
  state = AniStates.READY;
}

void keyPressed() {
  switch (Character.toLowerCase(key)) {
  case ' ':
  case ENTER:
    // Switch between running and paused state when pressing space
    playPause();
    //player.song().cue(0);
    break;
  case '1':
  case '2':
  case '3':
  case '4':
  case '5':
  case '6':
  case '7':
  case '8':
  case '9':
  case '0':
    dode.setSmooth(key - 48);
    break;
  case 'd':
    for (int i = 10; i>0; i--) {
      Dodecahedron d = new Dodecahedron();
      d.position = new PVector(random(width), random(height), 1000);
      d.rad = 1;
      d.rotationSpeed = new PVector(0.1, 0.1, 0.1);
      d.speed = new PVector(0, 0, -40);
      dodes.add(d);
    }
    break;
  default:
    // Do nothing
    break;
  }
  super.keyPressed();
}

/**
 * Play pause method changes the running state, shows/hides the gui and either resumes or pauses all animations.
 * Do not change the visibility, because the gui relies on it being 'public'
 */
public void playPause() {
  state = state == AniStates.RUNNING ? AniStates.PAUSED : AniStates.RUNNING;
  if (state == AniStates.RUNNING) {
    player.song().play();
    gui.hide();
  } else {
    player.song().pause();
    gui.show();
  }
}