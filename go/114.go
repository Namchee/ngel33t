package main

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func flatten(node *TreeNode) *TreeNode {
	return flattenTree(node, nil)
}

func flattenTree(node *TreeNode, prev *TreeNode) *TreeNode {
	if node == nil {
		return prev
	}

	prev = flattenTree(node.Right, prev)
	prev = flattenTree(node.Left, prev)

	node.Right = prev
	node.Left = nil

	return node
}
