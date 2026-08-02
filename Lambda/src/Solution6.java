import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Solution6 {

	public static int solution(String x) {
		final int v = Integer.valueOf(x);
		final Tree tree = new Tree(v);
		tree.fill();
		tree.fillLeafs();
		return tree.leafs.get(0);	
	}

	public static class Tree {
		private Node root = null;
		private List<Integer> leafs = new ArrayList<Integer>();
		public Tree(int v) { root = new Node(v); }
		
		public void fill() {
			fillNode(root);
		}
		
		public void fillLeafs() {
			findLeaf(root);
			Collections.sort(leafs);
		}

		private void findLeaf(Node node) {
			if (node == null) return;
			if (node.isLeaf()) {
				leafs.add(node.deep);
				return;
			}
			findLeaf(node.left);
			findLeaf(node.right);
		}
		
		private void fillNode(Node node) {
			int v = node.value;
			int deep = node.deep;
			if (v <= 1) return;
			if (v == 2) {
				final Node last = new Node(1);
				last.deep = deep + 1; 
				node.left = last;
				return;
			}
			
			if ((v % 2) == 0) {
				final Node left = new Node(v / 2);
				node.left = left;
				left.deep = deep + 1;
				fillNode(left);
				return;
			}
			
			final Node left = new Node(v - 1);
			final Node right = new Node(v + 1);
			node.left = left;
			node.right = right;
			left.deep = deep + 1;
			right.deep = deep + 1;
			fillNode(left);
			fillNode(right);
		}
		
	}
	
	public static class Node {
		int value = 0;
		int deep = 0;
		Node left = null;
		Node right = null;
		public Node(int v) { value = v; }
		public boolean isLeaf() { return left == null && right == null; }
	}
	
}