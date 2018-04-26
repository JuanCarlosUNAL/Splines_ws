class Hermite extends Interpolador{

  List<Vector> points;
  float spaceBetweenSamples = 0.1;

  @Override
  public String nombre(){
    return "Hermite";
  }

  @Override
  public void setPoints(List<Vector> points){
    this.points = points;
  }

  @Override
  public void draw(){
    int n = points.size();

    for(int i = 1 ; i <= n - 3 ; i++){
      Vector m0 = m(i);
      Vector m1 = m(i + 1);

      Vector p0 = points.get(i);
      Vector p1 = points.get(i + 1);

      Vector previousPoint = p0;

      for(float t = 0 ; t < 1 ; t += spaceBetweenSamples) {
        Vector firstHalf = Vector.add ( Vector.multiply(p0,h00(t)), Vector.multiply(m0,h10(t)) );
        Vector secondHalf = Vector.add ( Vector.multiply(p1,h01(t)), Vector.multiply(m1,h11(t)) );

        Vector pt = Vector.add( firstHalf, secondHalf );
        line( previousPoint, pt );
        previousPoint = pt;
      }

      line( previousPoint, p1 );
    }
  }

  private float h00(float t) {
    return (1 + 2*t)*(1 - t)*(1 - t);
  }

  private float h10(float t) {
    return t*(1 - t)*(1 - t);
  }

  private float h01(float t) {
    return t*t*(3 - 2*t);
  }

  private float h11(float t) {
    return t*t*(t - 1);
  }

  private Vector m(int k) {
    return Vector.multiply( Vector.add( points.get(k - 1), points.get(k + 1) ), 0.5 );
  }
}