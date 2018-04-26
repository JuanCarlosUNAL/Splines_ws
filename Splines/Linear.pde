class Linear extends Interpolador{

  protected List<Vector> puntos;

  @Override
  public String nombre(){
    return "Linear";
  }

  @Override
  public void setPoints(List<Vector> puntos){
    this.puntos = puntos;
  }

  @Override
  public void draw(){
    for (int i = 0; i < puntos.size() - 1 ; ++i) {
      line( puntos.get(i),puntos.get(i+1) );
    }
  }
}