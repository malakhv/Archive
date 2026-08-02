import java.math.BigInteger;

public class Solution9 {
	
	private static BigInteger BI_0 = new BigInteger("0");
	private static BigInteger BI_1 = BigInteger.ONE;
	private static BigInteger BI_2 = new BigInteger("2");
	
	public static int minWay = 0;

	public static int solution(String x) {
		minWay = 0;
		BigInteger v = new BigInteger(x);
		if (v.compareTo(BI_0) < 0) return 0; 
		findWay(v, 0);
		return minWay;
	}
	
	// Very very slowly on big value :(
	private static void findWay(BigInteger value, int d) {
		BigInteger v = value;
		int deep = d;

		if (v.compareTo(BI_1) < 1) return;
		if (v.compareTo(BI_2) == 0) {
			deep++;
			if (minWay > deep || minWay == 0) minWay = deep;
			return;
		}

		if (deep >= minWay && (minWay != 0)) {
			return;
		}
		
		if (v.mod(BI_2).equals(BI_0)) {
			deep += 1;
			findWay(v.shiftRight(1), deep);
			return;
		}

		deep++;
		findWay(v.subtract(BI_1), deep);
		findWay(v.add(BI_1), deep);
	}
}