package main

import (
	"math"
	"slices"
)

func minimumDifference(nums []int, k int) int {
	if k == 1 {
		return 0
	}

	slices.Sort(nums)

	best := math.MaxInt

	for idx := 0; idx < len(nums)-k+1; idx++ {
		diff := nums[idx+k-1] - nums[idx]

		if diff < best {
			best = diff
		}
	}

	return best
}
