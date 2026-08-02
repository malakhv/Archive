import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

/**
 * Данн массив цыфр (от 0 до 9). Найти максимальное число, которое можно составить из этих цыфр, что бы оно делилось на 3 
 * */

public class Solution3 {
	
	public static int solution(int[] l) {
		
		List<Integer> list = sort(l);
		
		while (list.size() > 1) {
			
			int sum = sum(list);
			
			if ((sum % 3) == 0) return listToInt(list);
		
		for (int i = list.size() - 1; i >= 0; i--) {
			int s = sum - list.get(i); 
			if ((s % 3) == 0) {
				list.remove(i);
				return listToInt(list);
			}
		}
		
		list.remove(list.size() - 1);
		}
		
		list = sort(l);
		for (int i = 0; i < list.size(); i++) {
			int s = list.get(i);
			if ((s % 3) == 0) {
				return s;
			}
		}
		
		return 0;
		
	}
	
	private static int sum(List<Integer> list) {
		int s = 0;
		for (int i = 0; i < list.size(); i++) {
			s += list.get(i);
		}
		return s;
	}
	
	private static List<Integer> sort(int[] l) {
		final LinkedList<Integer> list = new LinkedList<Integer>();
		for (int i = 0; i < l.length; i++) {
			list.add(l[i]);
		}
		list.sort(comp);
		return list;
	}
	
	private static Comparator<Integer> comp = new Comparator<Integer>() {
		
		@Override
		public int compare(Integer o1, Integer o2) {
			return o2 - o1;
		}
	};
	
	private static int listToInt(List<Integer> list) {
		final StringBuilder sb = new StringBuilder();
		for (int i = 0; i < list.size(); i++) {
			sb.append(list.get(i));
		}
		return Integer.valueOf(sb.toString());
	}
	
}