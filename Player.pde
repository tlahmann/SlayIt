import ddf.minim.AudioPlayer;
import ddf.minim.Minim;

/**
 * Player class. The player stores and replays the song for the animation
 *
 * @author Tobias Lahmann
 * Date: 25.03.2017.
 */
public class Player {
  private AudioPlayer song;

  /**
   * Player constructor for the song to play in the animation
   *
   * @param filePath the path for the song
   */
  public Player(String filePath) {
    Minim minim = new Minim(SlayIt.canvas);
    song = minim.loadFile(filePath);
  }

  /**
   * Getter method for the song
   *
   * @return the song set for this animation
   */
  public AudioPlayer song() {
    return this.song;
  }
}