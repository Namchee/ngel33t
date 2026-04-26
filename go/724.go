package main

func pivotIndex(nums []int) int {
	left := 0
	right := 0

	pivot := 0

	for i := 1; i < len(nums); i++ {
		right += nums[i]
	}

	if left == right {
		return 0
	}

	for pivot < len(nums)-1 {
		left += nums[pivot]
		right -= nums[pivot+1]

		pivot++

		if left == right {
			return pivot
		}
	}

	if left == right {
		return len(nums) - 1
	}

	return -1
}
