import de.looksgood.ani.easing.Easing;

/**
 * A class to hold all needed information for the variation of parameters in our animation
 *
 * @author Tobias Lahmann
 * Date: 18.04.2018
 */
public class CustomAnimation implements Comparable<CustomAnimation> {
  Object object;
  float start;
  float duration;
  float value;
  String param;
  Easing easing;

  /**
   * Constructor of the CustomAnimation
   *
   * @param start          start cue of the animation in seconds
   * @param duration       the duration of the animation in seconds
   * @param param         what parameter should be changed
   * @param animateToValue what the finish value of the animation should be
   * @param easing           the animation mode as Easing
   */
  CustomAnimation(Object object, float start, float duration, String param, float animateToValue, Easing easing) {
    this.object = object;
    this.start = start;
    this.duration = duration;
    this.param = param;
    this.value = animateToValue;
    this.easing = easing;
  }

  /**
   * Compares the starting time of one animation to another. Used for sorting.
   *
   * @param other The other animation
   * @return a negative integer, zero, or a positive integer as this object
   * is less than, equal to, or greater than the specified object.
   */
  @Override
    public int compareTo(CustomAnimation other) {
    return ((this.start - other.start) < 0) ? -1 : 1;
  }

  @Override
    public String toString() {
    return this.param + ": " + this.start + " for " + this.duration + "s --> " + this.value;
  }
}