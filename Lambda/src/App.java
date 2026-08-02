import java.math.BigInteger;
import java.text.DecimalFormat;

public class App {

	public static void main(String[] args) {
		/* test1();
		test2();
		System.out.println("========================");
		
		test3();
		test4();
		test5();
		test6(); */

		/* test7();
		test8();
		test9();
		test10();
		test11();
		test12(); */
		
		/* test13();
		test14();
		test15(); */
		
		/* test18();
		test19();
		test20();
		test21(); */
		
		//test16();
		//test17();
		
		//test21();
		
		//test22();
		
		
		//test23();
		//test24();
		//test25();
		/* test26();
		test27(); */
		
		//test28();
		
		//test29();
		compare();

	}
	
	private static void compare() {
		for (long i = 0L; i < 1001L; i++) {
			int w1 = Solution7.solution(String.valueOf(i));
			int w2 = Solution8.solution(String.valueOf(i));
			int w3 = Solution9.solution(String.valueOf(i));
			System.out.print(i); System.out.print(": ");
			System.out.print(w1); System.out.print(" = "); System.out.print(w2); System.out.print(" = "); System.out.print(w3);
			if (w1 != w2 || w1 != w3) {
				System.out.println("  -  Attention!!!"); break;
			} else {
				System.out.println("");
			}
		}
	}
	
	private static void test29() {
		int s = Solution9.solution("123456789123456789");
		System.out.println(s);
	}
	
	private static void test23() {
		int s = Solution8.solution("0");
		System.out.println(s);
	}
	
	private static void test24() {
		int s = Solution8.solution("1");
		System.out.println(s);
	}
	
	private static void test25() {
		int s = Solution8.solution("2");
		System.out.println(s);
	}
	
	private static void test26() {
		int s = Solution8.solution("4");
		System.out.println(s);
	}
	
	private static void test27() {
		int s = Solution8.solution("15");
		System.out.println(s);
	}
	
	private static void test28() {
		int s = Solution7.solution("1234567890123");
		System.out.println(s);
	}
	
	private static void test22() {
		final String d = "1";
		String str = null;
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < 309; i++) {
			sb.append(d);
		}
		str = sb.toString();
		BigInteger bi = new BigInteger(str);
		String str2 = bi.toString();
		return;
	}
	
	private static void test16() {
		int s = Solution6.solution("4");
		System.out.println(s);
	}
	
	private static void test17() {
		int s = Solution6.solution("15");
		System.out.println(s);
	}
	
	private static void test18() {
		int s = Solution6.solution("0");
		System.out.println(s);
	}
	
	private static void test19() {
		int s = Solution6.solution("1");
		System.out.println(s);
	}
	
	private static void test20() {
		int s = Solution6.solution("2");
		System.out.println(s);
	}
	
	private static void test21() {
		int s = Solution6.solution("1111111111");
		System.out.println(s);
	}
	
	private static void test13() {
		int v1 = Solution4.solution(0, 3);
		int v2 = Solution5.getValue(0, 3);
		System.out.print(v1); System.out.print(" = "); System.out.println(v2);  
	}
	
	private static void test14() {
		int v1 = Solution4.solution(17, 4);
		int v2 = Solution5.getValue(17, 4);
		System.out.print(v1); System.out.print(" = "); System.out.println(v2);
	}
	
	private static void test15() {
		int v1 = Solution4.solution(85, 21);
		int v2 = Solution5.getValue(85, 21);
		System.out.print(v1); System.out.print(" = "); System.out.println(v2);
	}
	
	private static void test7() {
		int[] l = {3, 1, 4, 1, 0};
		int v = Solution3.solution(l);
		System.out.println(v);
	}
	
	private static void test8() {
		int[] l = {3, 1, 4, 1, 5, 9, 0};
		int v = Solution3.solution(l);
		System.out.println(v);
	}
	
	private static void test9() {
		int[] l = {1, 3, 1};
		int v = Solution3.solution(l);
		System.out.println(v);
	}
	
	private static void test10() {
		int[] l = {1, 3, 1, 3};
		int v = Solution3.solution(l);
		System.out.println(v);
	}
	
	private static void test11() {
		int[] l = {9};
		int v = Solution3.solution(l);
		System.out.println(v);
	}
	
	private static void test12() {
		int[] l = {8, 4};
		int v = Solution3.solution(l);
		System.out.println(v);
	}
	
	
	private static void test3() {
		for (int i = 0; i < 15; i++) {
			long v1 = Solution2.getValueY(i);
			long v2 = Solution2.getValueY2(i);
			System.out.print(v1); System.out.print(" = "); System.out.print(v2); System.out.print(", "); 
		}
		System.out.println(" ");
	}
	
	private static void test4() {
		String id = Solution2.solution(3, 2);
		System.out.println(id);
	}
	
	private static void test5() {
		String id = Solution2.solution(5, 10);
		System.out.println(id);
	}

	private static void test6() {
		String id = Solution2.solution(5, 100000);
		System.out.println(id);
	}
	
	private static void test1() {
		int[] x1 = {13, 5, 6, 2, 5}; int[] y1 = {5, 2, 5, 13};
		int result = Solution1.solution(x1, y1);
		System.out.print(result); System.out.print(" = ");
		result = Solution1.solution(y1, x1);
		System.out.println(result);
	}
	
	private static void test2() {
		int[] x1 = {14, 27, 1, 4, 2, 50, 3, 1}; int[] y1 = {2, 4, -4, 3, 1, 1, 14, 27, 50};
		int result = Solution1.solution(x1, y1);
		System.out.print(result); System.out.print(" = ");
		result = Solution1.solution(y1, x1);
		System.out.println(result);
	}

}


