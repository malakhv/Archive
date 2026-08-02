import java.util.ArrayList;
import java.util.List;

public class Solution5 {
	
    public static int solution(int start, int length) {
    	int[][] matrix = getMatrix(start, length);
    	final int size = length + 1;
    	int r = size;
    	int value = 0;
    	
    	final List<Integer> list = new ArrayList<Integer>();

    	for (int i = 0; i < size; i++ ) {
    		r--;
    		for (int j = 0; j < size; j++) {
    			if (r == j) break;  			
   				value = value ^ matrix[i][j];
    			list.add(matrix[i][j]);
    		}
    	}
    	return value;
    }
  
    
    public static int getValue(int start, int length) {
    	int value = 0;
    	final int size = length + 1;
    	int r = size;
    	for (int i = 0; i < size; i++ ) {
    		r--;
    		for (int j = 0; j < size; j++) {
    			if (r == j) continue;
    			if (r < j)  {
    				start++; continue;
    			}
    			value = value ^ start++;
    		}
    	}
    	return value;
    }
    
    private static int[][] getMatrix(int start, int length) {
    	
    	int value = 0;
    	
    	final int size = length + 1;
    	int[][] matrix = new int[size][size];
    	int r = size;
    	for (int i = 0; i < size; i++ ) {
    		r--;
    		for (int j = 0; j < size; j++) {
    			if (r == j) matrix[i][j] = 0;
    			else {
    				value = value ^ start;
    				matrix[i][j] = start++;
    				
    			}
    		}
    	}
    	return matrix;
    }
	
}