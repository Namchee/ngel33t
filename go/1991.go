package main

func findMiddleIndex(nums []int) int {
	a := 0
	b := 0

	idx := 0

	for i := 1; i < len(nums); i++ {
		b += nums[i]
	}

	if a == b {
		return 0
	}

	for idx < len(nums)-1 {
		a += nums[idx]
		b -= nums[idx+1]

		idx++

		if a == b {
			return idx
		}
	}

	if a == b {
		return len(nums) - 1
	}

	return -1
}
