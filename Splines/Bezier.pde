class Hermite implements Interpolador{

  List<Vector> puntos;

  public void setPoints(List<Vector> puntos){
    this.puntos = puntos;
  }

  public void draw(){
    for (int i = 0; i < puntos.size() - 1 ; ++i) {
      Util.lineVector( puntos.get(i),puntos.get(i+1) );
    }
  }
}