package main

type NodeMetadata struct {
	depth  int
	parent *TreeNode
}

func searchTreeNode(node *TreeNode, target int, prev *TreeNode, depth int) *NodeMetadata {
	if node == nil {
		return nil
	}

	if node.Val == target {
		return &NodeMetadata{
			depth:  depth,
			parent: prev,
		}
	}

	left := searchTreeNode(node.Left, target, node, depth+1)
	if left != nil {
		return left
	}

	return searchTreeNode(node.Right, target, node, depth+1)
}

func isCousins(root *TreeNode, x int, y int) bool {
	a := searchTreeNode(root, x, nil, 0)
	b := searchTreeNode(root, y, nil, 0)

	if a == nil || b == nil {
		return false
	}

	return a.depth == b.depth && a.parent.Val != b.parent.Val
}
