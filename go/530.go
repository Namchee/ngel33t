package main

const SENTINEL int = 100000

type State struct {
	prev int
	best int
}

func (s *State) traverse(node *TreeNode) {
	if node == nil {
		return
	}

	s.traverse(node.Left)
	if s.prev != -1 {
		diff := s.prev - node.Val
		if diff < 0 {
			diff *= -1
		}

		s.best = min(diff, s.best)
	}
	s.prev = node.Val
	s.traverse(node.Right)
}

func getMinimumDifference(root *TreeNode) int {
	state := &State{prev: -1, best: SENTINEL}
	state.traverse(root)

	return state.best
}
