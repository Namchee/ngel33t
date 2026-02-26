package main

func constructMaximumBinaryTree(nums []int) *TreeNode {
	if len(nums) == 0 {
		return nil
	}

	middle := 0

	for idx, num := range nums {
		if num > nums[middle] {
			middle = idx
		}
	}

	root := &TreeNode{Val: nums[middle], Left: constructMaximumBinaryTree(nums[0:middle]), Right: constructMaximumBinaryTree(nums[middle+1 : len(nums)])}

	return root
}
