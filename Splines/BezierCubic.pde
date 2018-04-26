public class BezierCubic extends Interpolador {
  
  List<Bezier> groups = new ArrayList<Bezier>();
  List<Node> controlPoints = new ArrayList<Node>();
  
  @Override
  public String nombre(){
    return "Bezier cúbico";
  }

  @Override
  public void setPoints(List<Vector> puntos){
    groups.clear();
    controlPoints.clear();
    for(int i = 0; i < puntos.size(); i+=2){
      createGroup(i, puntos);
    }
  }

  @Override
  public void draw(){
    fill(0, 0, 255);
    stroke(0, 0, 0);
    
    for(int i = 0; i < controlPoints.size() - 1; i+= 2){
      scene.drawPickingTarget( controlPoints.get(i) );
      scene.drawPickingTarget( controlPoints.get(i+1) );
      line(controlPoints.get(i).position(), controlPoints.get(i+1).position());
    }

    stroke(255, 0, 255);
    for(Bezier b : groups){
      b.draw();
    }
  }
  
  private void createGroup(final int a, List<Vector> points){
    List<Vector> group = new ArrayList<Vector>();
    
    if(a+1 >= points.size())
      return;
    
    group.add( points.get(a) );
    
    if(a-1 > 0){
      Vector normal = Vector.subtract( points.get(a+1), points.get(a-1) );
      // normal.normalize();
      normal.add( points.get(a) );
      group.add( normal );
      Node ctrlPoint = new OrbitNode(scene);
      ctrlPoint.setPosition(normal);
      controlPoints.add (ctrlPoint);
    }

    group.add( points.get(a+1) );

    if(a+3 < points.size()){
      Vector normal = Vector.subtract( points.get(a+1), points.get(a+3) );
      // normal.normalize();
      normal.add( points.get(a+2) );
      group.add( normal );
      Node ctrlPoint = new OrbitNode(scene);
      ctrlPoint.setPosition(normal);
      controlPoints.add (ctrlPoint);
    }

    if(a+3 < points.size())
        group.add( points.get(a+2) );

    Bezier bezier = new Bezier();
    bezier.setPoints( group );
    groups.add( bezier );

    return;

  }

}