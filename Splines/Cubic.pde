public class Cubic{
    private float a;
    private float b;
    private float c;
    private float d;

    public Cubic(float a, float b, float c, float d){
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
    }

    public float result(float t){
        // Y_i(t) = a + b*t + c*t²)+d*t³
        return a + b*t + c*pow(t,2)+d*pow(t,3);
    }
}