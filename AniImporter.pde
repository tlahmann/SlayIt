import de.looksgood.ani.AniConstants;
import de.looksgood.ani.easing.Easing;
import processing.core.PApplet;
import processing.data.JSONArray;
import processing.data.JSONObject;

import java.util.ArrayList;

/**
 * Abstract class to import a list of animations, provided in a json file to an arrayList of custom animations
 *
 * @author Tobias Lahmann
 * Date: 18.04.2018
 * @see de.uulm.mi.gdg.utils.CustomAnimation
 */
public class AniImporter {
  /**
   * Method to import a list of animatios from a JSON file and convert it to an ArrayList of Custom Animations
   *
   * @param filePath the file path for the animation
   * @param param    the parameter that these animations shall be applied to
   * @return a list of custom animations to process
   * @see de.uulm.mi.gdg.utils.CustomAnimation
   */
  public ArrayList<CustomAnimation> importAnimation(Object aniObject, String filePath, String param) {
    JSONObject file = loadJSONObject(filePath);
    JSONArray animations = file.getJSONArray(param);

    ArrayList<CustomAnimation> anis = new ArrayList<CustomAnimation>();
    for (int i = 0; i < animations.size(); i++) {
      JSONObject o = animations.getJSONObject(i);
      float start = o.getFloat("start");
      float duration = o.getFloat("duration");
      float value = o.getFloat("value");
      String easingString = o.getString("easing");
      Easing easing = determineEasing(easingString);

      anis.add(new CustomAnimation(aniObject, start, duration, param, value, easing));
    }

    return anis;
  }

  /**
   * Method to chose an easing method based on the string provided
   * This method will take an easing method as string and 'convert' it to the corresponding
   * ANI easing method
   *
   * @param ease the easing as string
   * @return Ani easing method
   * @see de.looksgood.ani.easing.Easing
   */
  private Easing determineEasing(String ease) {
    Easing e;
    switch (ease) {
    case "quad_in":
      e = AniConstants.QUAD_IN;
      break;
    case "quad_out":
      e = AniConstants.QUAD_OUT;
      break;
    case "quad_in_out":
      e = AniConstants.QUAD_IN_OUT;
      break;
    case "cubic_in":
      e = AniConstants.CUBIC_IN;
      break;
    case "cubic_out":
      e = AniConstants.CUBIC_OUT;
      break;
    case "cubic_in_out":
      e = AniConstants.CUBIC_IN_OUT;
      break;
    case "quart_in":
      e = AniConstants.QUART_IN;
      break;
    case "quart_out":
      e = AniConstants.QUART_OUT;
      break;
    case "quart_in_out":
      e = AniConstants.QUART_IN_OUT;
      break;
    case "quint_in":
      e = AniConstants.QUINT_IN;
      break;
    case "quint_out":
      e = AniConstants.QUINT_OUT;
      break;
    case "quint_in_out":
      e = AniConstants.QUINT_IN_OUT;
      break;
    case "sine_in":
      e = AniConstants.SINE_IN;
      break;
    case "sine_out":
      e = AniConstants.SINE_OUT;
      break;
    case "sine_in_out":
      e = AniConstants.SINE_IN_OUT;
      break;
    case "circ_in":
      e = AniConstants.CIRC_IN;
      break;
    case "circ_out":
      e = AniConstants.CIRC_OUT;
      break;
    case "circ_in_out":
      e = AniConstants.CIRC_IN_OUT;
      break;
    case "expo_in":
      e = AniConstants.EXPO_IN;
      break;
    case "expo_out":
      e = AniConstants.EXPO_OUT;
      break;
    case "expo_in_out":
      e = AniConstants.EXPO_IN_OUT;
      break;
    case "back_in":
      e = AniConstants.BACK_IN;
      break;
    case "back_out":
      e = AniConstants.BACK_OUT;
      break;
    case "back_in_out":
      e = AniConstants.BACK_IN_OUT;
      break;
    case "bounce_in":
      e = AniConstants.BOUNCE_IN;
      break;
    case "bounce_out":
      e = AniConstants.BOUNCE_OUT;
      break;
    case "bounce_in_out":
      e = AniConstants.BOUNCE_IN_OUT;
      break;
    case "elastic_in":
      e = AniConstants.ELASTIC_IN;
      break;
    case "elastic_out":
      e = AniConstants.ELASTIC_OUT;
      break;
    case "elastic_in_out":
      e = AniConstants.ELASTIC_IN_OUT;
      break;
    default:
      e = AniConstants.LINEAR;
      break;
    }
    return e;
  }
}