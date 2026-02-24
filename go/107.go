package main

import "slices"

func traverse2(node *TreeNode, level int, container map[int][]int) {
	if node == nil {
		return
	}

	_, ok := container[level]
	if !ok {
		container[level] = make([]int, 0)
	}

	traverse2(node.Left, level+1, container)
	container[level] = append(container[level], node.Val)
	traverse2(node.Right, level+1, container)
}

func levelOrderBottom(root *TreeNode) [][]int {
	container := map[int][]int{}

	traverse2(root, 0, container)

	keys := make([]int, 0, len(container))
	for k := range container {
		keys = append(keys, k)
	}

	slices.Sort(keys)

	result := [][]int{}

	for idx := len(keys) - 1; idx >= 0; idx-- {
		result = append(result, container[keys[idx]])
	}

	return result
}
