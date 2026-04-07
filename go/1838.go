package main

import "slices"

func maxFrequency(nums []int, k int) int {
	slices.Sort(nums)

	left := 0
	need := 0
	best := 0

	for i := 0; i < len(nums); i++ {
		if i > 0 {
			need += (nums[i] - nums[i-1]) * (i - left)
		}

		for need > k {
			need -= nums[i] - nums[left]
			left++
		}

		sz := i - left + 1
		if sz > best {
			best = sz
		}
	}

	return best
}
