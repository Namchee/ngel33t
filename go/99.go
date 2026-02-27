package main

import "math"

type treeState struct {
	prev   *TreeNode
	first  *TreeNode
	second *TreeNode
}

func (s *treeState) traverse(node *TreeNode) {
	if node == nil {
		return
	}

	s.traverse(node.Left)
	if s.prev != nil && s.prev.Val >= node.Val {
		if s.first == nil {
			s.first = s.prev
		}

		s.second = node
	}
	s.prev = node

	s.traverse(node.Right)
}

func recoverTree(root *TreeNode) {
	state := &treeState{
		prev: &TreeNode{Val: math.MinInt64},
	}

	state.traverse(root)

	if state.first != nil && state.second != nil {
		temp := state.first.Val
		state.first.Val = state.second.Val
		state.second.Val = temp
	}
}
