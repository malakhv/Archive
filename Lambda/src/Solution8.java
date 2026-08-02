import java.math.BigInteger;

public class Solution8 {
	
	private static BigInteger BI_M1 = new BigInteger("-1");
	private static BigInteger BI_0 = new BigInteger("0");
	private static BigInteger BI_1 = BigInteger.ONE;
	private static BigInteger BI_2 = new BigInteger("2");
	

	public static int solution(String x) {
		BigInteger value = new BigInteger(x);
		if (value.compareTo(BI_0) < 0) return 0;
		int s1 = getStep(value, BI_1);
		int s2 = getStep(value, BI_M1);
		return s1 > s2 ? s2 : s1; 
	}
	
	private static int minWay = 0;

	private static int getStep(BigInteger v, BigInteger d) {
		int step = 0;
		if (v.compareTo(BI_0) == 0) return 0;
		if (v.compareTo(BI_1) == 0) return 0;
		if (v.compareTo(BI_1) == 0) return 1;
		 
		if (!v.mod(BI_2).equals(BI_0)) {
			v = v.add(d);
			step++;
		}
		
		do {
			if (!v.mod(BI_2).equals(BI_0)) {
				int s1 = getStep(v, BI_1);
				int s2 = getStep(v, BI_M1);
				v = s1 < s2 ? v.add(BI_1) : v.add(BI_M1);
				step++; 
				continue;
			}
			//v = v.divide(BI_2);
			v = v.shiftRight(1);
			step++;
		} while (v.compareTo(BI_2) >= 0);

		return step;
	}	
}