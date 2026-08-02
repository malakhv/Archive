import java.math.BigInteger;

public class Solution7 {
	
	private static BigInteger BI_0 = new BigInteger("0");
	private static BigInteger BI_1 = BigInteger.ONE;
	private static BigInteger BI_2 = new BigInteger("2");	

	public static int solution(String x) {
		final Tree tree = new Tree(x);
		tree.fill();
		return tree.getShortWay(); 
	}

	public static class Tree {
		private Node root = null;
		private int minWay = 0;
		
		public Tree(String value) {
			root = new Node(value);
		}
		
		public int getShortWay() {
			return minWay;
		}
		
		public void fill() {
			fillNode(root);
		}
		
		private void fillNode(Node node) {
			BigInteger v = node.value;
			int deep = node.deep;
			
			if (v.compareTo(BI_0) == 0) return;
			if (v.compareTo(BI_1) == 0) return;
			if (v.compareTo(BI_2) == 0) {
				deep++;
				if (minWay > deep || minWay == 0) minWay = deep;
				return;
			}

			if (deep >= minWay && (minWay != 0)) {
				return;
			}
			
			if (v.mod(BI_2).equals(BI_0)) {
				final Node left = new Node(v.shiftRight(1));
				node.left = left;
				left.deep = deep + 1;
				fillNode(left);
				return;
			}
			
			final Node left = new Node(v.subtract(BI_1));
			final Node right = new Node(v.add(BI_1));
			node.left = left;
			node.right = right;
			left.deep = deep + 1;
			right.deep = deep + 1;
			fillNode(left);
			fillNode(right);
		}
		
	}
	
	public static class Node {
		BigInteger value = null;
		int deep = 0;
		Node left = null;
		Node right = null;
		public Node(BigInteger v) {
			value = v;
		}
		public Node(String v) { value = new BigInteger(v); }
		public boolean isLeaf() { return left == null && right == null; }
	}
	
}