import org.jblas.Solve;
import org.jblas.FloatMatrix;
class Natural extends Interpolador{
    
    protected List<Vector> puntos;

    @Override
    public String nombre(){
        return "Cubic Natural";
    }

    @Override
    public void setPoints(List<Vector> puntos){
        this.puntos = puntos;
    }

    @Override
    public void draw(){
        Matrix matriz = new Matrix();
        
        int n = puntos.size();
       
        Vector p0 = puntos.get(0);
        

        Vector previousPoint = p0;
        Cubic px,py,pz;
       
        /* Ds is list of D_i solutions for each component (x, y, z )*/
        List<FloatMatrix> Ds = findDs();
        /* 
         * In Natural cubic Splines Y_0 = Y_(n-1) = 0
         * i E {0,1,2,...,n-2} in array representation
        */
        for( int i = 0; i < n-1; i++){        
            px = findCoefficients(puntos.get(i).x(), puntos.get(i+1).x(), Ds.get(0).get(i), Ds.get(0).get(i+1));
            py = findCoefficients(puntos.get(i).y(), puntos.get(i+1).y(), Ds.get(1).get(i), Ds.get(1).get(i+1));
            pz = findCoefficients(puntos.get(i).z(), puntos.get(i+1).z(), Ds.get(2).get(i), Ds.get(2).get(i+1));

            Vector p1 = puntos.get(i + 1);
           
            /* x E [ 0,1 ] */
            for(float x = 0; x <= 1; x+=resolution){
                Vector pt = new Vector();
                pt.add(px.result(x),py.result(x),pz.result(x));
                line(previousPoint, pt);
                 previousPoint = pt;
            }
            line( previousPoint, p1 );
        }
    }

    public Cubic findCoefficients(float y, float nexty, Float Di, Float nextDi){
        float a = y;
        float b = Di;
        float c = 3*(nexty - y ) -2*Di -nextDi;
        float d = 2*(y -nexty) + Di+ nextDi;
        return new Cubic(a,b,c,d);
    }

    public List<FloatMatrix> findDs(){
        /* Construc Matriz F for each component ( x, y, z ) */
        int n = puntos.size();
        List<FloatMatrix> Ds = new ArrayList<FloatMatrix>();
        float [] fx = new float[n];
        float [] fy = new float[n];
        float [] fz = new float[n];
        
        
        fx[0] = 3*(puntos.get(1).x() - puntos.get(0).x());
        fx[n-1] = 3*(puntos.get(n-1).x() - puntos.get(n-2).x());
        
        fy[0] = 3*(puntos.get(1).y() - puntos.get(0).y());
        fy[n-1] = 3*(puntos.get(n-1).y() - puntos.get(n-2).y());
        
        fz[0] = 3*(puntos.get(1).z() - puntos.get(0).z());
        fz[n-1] = 3*(puntos.get(n-1).z() - puntos.get(n-2).z());

        for( int i = 1; i < n-2; i++)
        {
            fx[i] = 3*(puntos.get(i+1).x() - puntos.get(i-1).x());
            fy[i] = 3*(puntos.get(i+1).y() - puntos.get(i-1).y());
            fz[i] = 3*(puntos.get(i+1).z() - puntos.get(i-1).z());
        }

        float [][] m = generateMMatrix(n);
        // for( int col = 0; col < n; col++){
        //     for( int row = 0; row< n; row++){
        //         System.out.print( m[row][col] );
        //         System.out.print( "  " );
        //     }
        //     System.out.println("");
        // }

        /* Solve MxD = F , where D contains the D_i solutions for each polynomial  */
        FloatMatrix M = new FloatMatrix(m);
        FloatMatrix Fx = new FloatMatrix(fx);
        FloatMatrix Fy = new FloatMatrix(fy);
        FloatMatrix Fz = new FloatMatrix(fz);
        

        Ds.add(0,Solve.solve(M,Fx));
        Ds.add(1,Solve.solve(M,Fy));
        Ds.add(2,Solve.solve(M,Fz));
        
        /* Necesary for cubic Natural Spline condition  ? 
            for(int i = 0; i < 3; i++){
            Ds.get(i).put(0,0);
            Ds.get(i).put(n-1,0);
            }
        */
    
        return Ds;
    }

    public float[][] generateMMatrix(int n){
        float [][] m = new float[n][n];
        
        for( int col = 0; col < n; col++)
            for( int row = 0; row< n; row++)
                m[row][col] = 0;

        for( int row = 0; row< n; row++){
            if( row == 0 ){
                m[row][row] = 2;
                m[row][row+1] = 1;
            }
            else if(row == n-1){
                m[row][row-1] = 1;
                m[row][row] = 2;
            }
            else{
                 m[row][row-1] = 1;
                 m[row][row] = 4;
                 m[row][row+1] = 1;
                }
        }
        return m;
    }
}
