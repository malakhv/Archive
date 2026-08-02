
public class Solution1 {
	
    public static int solution(int[] x, int[] y) {
        if (x.length > y.length) {
            return find(x, y);
        } else {
            return find(y,x);
        }
    }
    
    // x.length > y length
    public static int find(int[] x, int[] y) {
        boolean has = true;
        for (int i = 0; i < x.length; i++) {
            has = has(y, x[i]);
            if (!has) return x[i];
        }
        return 0; // Ha ha :)
    }
    
    public static boolean has(int x[], int v) {
        for (int i = 0; i < x.length; i++) {
            if (x[i] == v) return true;
        }
        return false;
    }
}
