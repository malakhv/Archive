
public class Solution2 {
	
    public static String solution(long x, long y) {
       final long id = getId(x, y);
       return String.valueOf(id);
    }
    
    public static long getId(long x, long y) {
    	x = x - 1L;
    	y = y - 1L;
    	if (x == 0 && y == 0) return 1;
    	return (x + y) + getValueY2(x + y - 1L ) + x;
    }
    
    public static long getValueY(long y) {
    	if (y == 0) return 1L;
    	return y + getValueY(y - 1L);
    }
    
    public static long getValueY2(long y) {
    	if (y == 0) return 1L;
    	long ret = 1L;
    	for (long i = 1; i <= y; i++) {
    		ret = ret + i; 
    	}
    	return ret;
    	//return y + getValueY(y - 1L);
    }
    
}
