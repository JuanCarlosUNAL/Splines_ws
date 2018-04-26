/**
 * Splines.
 *
 * Here we use the interpolator.keyFrames() nodes
 * as control points to render different splines.
 *
 * Press ' ' to change the spline mode.
 * Press 'g' to toggle grid drawing.
 * Press 'c' to toggle the interpolator path drawing.
 * Press 'r' to chnage the control points.
 */

import java.util.List;
import java.util.ArrayList;

import frames.input.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

// global variables
// modes: 0 natural cubic spline; 1 Hermite;
// 2 (degree 7) Bezier; 3 Cubic Bezier
int mode;

Scene scene;
Interpolator interpolator;
OrbitNode eye;
boolean drawGrid = true, drawCtrl = true;
ArrayList<Interpolador> interpoladores = new ArrayList<Interpolador>();

//Choose P3D for a 3D scene, or P2D or JAVA2D for a 2D scene
String renderer = P3D;

void setup() {
  size(800, 800, renderer);
  scene = new Scene(this);
  eye = new OrbitNode(scene);
  eye.setDamping(0);
  scene.setEye(eye);
  scene.setFieldOfView(PI / 3);
  //interactivity defaults to the eye
  scene.setDefaultGrabber(eye);
  scene.setRadius(150);
  scene.fitBallInterpolation();
  interpolator = new Interpolator(scene, new Frame());
  // framesjs next version, simply go:
  //interpolator = new Interpolator(scene);

  interpoladores.add( new Linear() );
  interpoladores.add( new Bezier() );
  interpoladores.add( new BezierCubic() );
  interpoladores.add( new Hermite() );
  
  generateCtrlPoints();
}

void draw() {
  background(175);
  if (drawGrid) {
    stroke(255, 255, 0);
    scene.drawGrid(200, 50);
  }
  if (drawCtrl) {
    fill(255, 0, 0);
    stroke(255, 0, 255);
    for (Frame frame : interpolator.keyFrames())
      scene.drawPickingTarget((Node)frame);
  } else {
    fill(255, 0, 0);
    stroke(255, 0, 255);
    scene.drawPath(interpolator);
  }
  // implement me
  // draw curve according to control polygon an mode
  // To retrieve the positions of the control points do:
  List<Vector> puntos = new ArrayList<Vector>();
  for (Frame f : interpolator.keyFrames()) {
    puntos.add(f.position());
  }
  textSize(32);
  fill(0, 102, 153);
  text(interpoladores.get(mode).nombre(), 10, 60);
  interpoladores.get(mode).setPoints(puntos);
  interpoladores.get(mode).draw();
    
}

void keyPressed() {
  if (key == ' ')
    mode = (mode+1 < interpoladores.size()) ? mode+1 : 0;
  if (key == 'g')
    drawGrid = !drawGrid;
  if (key == 'c')
    drawCtrl = !drawCtrl;
  if(key == 'r')
    generateCtrlPoints();
}

void generateCtrlPoints(){
  interpolator.clear();
  // Using OrbitNodes makes path editable
  for (int i = 0; i < 8; i++) {
    Node ctrlPoint = new OrbitNode(scene);
    ctrlPoint.randomize();
    interpolator.addKeyFrame(ctrlPoint);
  }
}