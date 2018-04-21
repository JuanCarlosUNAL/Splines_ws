class Bezier implements Interpolador{

  protected List<Vector> puntos;
  private float resolution = 0.01;

  @Override
  public String nombre(){
    return "Bezier";
  }

  @Override
  public void setPoints(List<Vector> puntos){
    this.puntos = puntos;
  }

  @Override
  public void draw(){
    Vector a = puntos.get(0);
    Vector b = null;
    for(float i = resolution; i <= 1; i += resolution){
      b = bezier(i);
      line(a, b);
      a = b;
    }
  }

  private Vector bezier(final float t){
    int n = puntos.size();
    Vector ans = new Vector(0, 0, 0);
    for(int i = 0; i < n; i++){
      ans.add (
        Vector.multiply( puntos.get(i),  bernsteinPol(n-1,i,t) )
      );
    }
    return ans;
  }

  private float bernsteinPol(final int n, final int i, final float t){
    return binomial(n,i) * pow(t, i) * pow(1-t, n-i);
  }

  private int binomial(final int n, final int k){
    int num = 1, den = 1;
    for(int i = n; i > k; i--)
      num*=i;
    for(int i = 1; i <= (n-k); i++ )
      den *= i;
    return num/den;
  }

}