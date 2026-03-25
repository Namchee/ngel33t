package main

import "slices"

func numberGame(nums []int) []int {
	result := []int{}

	slices.Sort(nums)

	idx := 0

	for idx < len(nums) {
		a := nums[idx]
		idx++
		b := nums[idx]
		idx++

		result = append(result, b)
		result = append(result, a)
	}

	return result
}
