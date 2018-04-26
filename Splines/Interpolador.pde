abstract class Interpolador{

  float resolution;

  public abstract String nombre();
  public abstract void setPoints(List<Vector> punto);
  public abstract void draw();

  public void setResolution(float resolution) {
    this.resolution = resolution;
  }
}