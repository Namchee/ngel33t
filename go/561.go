package main

import "sort"

func arrayPairSum(nums []int) int {
	sort.Ints(nums)

	result := 0

	for idx := 0; idx < len(nums); idx += 2 {
		result += nums[idx]
	}

	return result
}
