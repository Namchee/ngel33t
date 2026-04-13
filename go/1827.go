package main

func minOperations2(nums []int) int {
	op := 0

	for i := 1; i < len(nums); i++ {
		if nums[i] > nums[i-1] {
			continue
		}

		diff := nums[i-1] + 1 - nums[i]
		nums[i] = nums[i-1] + 1
		op += diff
	}

	return op
}
