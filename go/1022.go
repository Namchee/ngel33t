/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
package main

func sumRootToLeaf(root *TreeNode) int {
	return traverse(root, 0)
}

func traverse(node *TreeNode, curr int) int {
	if node == nil {
		return 0
	}

	acc := (curr << 1) | node.Val

	if node.Left == nil && node.Right == nil {
		return acc
	}

	return traverse(node.Left, acc) + traverse(node.Right, acc)
}
