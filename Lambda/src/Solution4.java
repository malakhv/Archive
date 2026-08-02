import java.util.ArrayList;
import java.util.List;

public class Solution4 {
	
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
    
    private static int listXor(List<Integer> list) {
    	int ret = 0;
    	for (int i = 0; i < list.size(); i++) {
    		ret = ret ^ list.get(i);
    	}
    	return ret;
    }
    
    private static List<Integer> getNumberList(int start, int length) {
    	final List<Integer> list = new ArrayList<Integer>();
    	final int count = getNumberCount(length);
    	for (int i = 0; i < count; i++) {
    		list.add(start++);
    	}
    	return list;
    }
    
    private static int getNumberCount(int w) {
    	int c = 0;
    	for (int i = 1; i <= w; i++) c += i;
    	return c;
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