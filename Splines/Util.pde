public class UtilClass {
  public void lineVector(Vector a, Vector b){
    line(round(a.x()), round(a.y()), round(a.z()),
         round(b.x()), round(b.y()), round(b.z()));
  }
}

UtilClass Util = new UtilClass();