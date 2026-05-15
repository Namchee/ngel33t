package main

func leser(a, b int) int {
	if a > b {
		return b
	}

	return a
}

func findMin(nums []int) int {
	result := nums[0]
	start := 0
	end := len(nums) - 1

	for start <= end {
		// already in sroted range
		if nums[start] < nums[end] {
			result = leser(result, nums[start])
			break
		}

		mid := start + (end-start)/2
		result = leser(result, nums[mid])

		// maybe sorted
		if nums[mid] >= nums[start] {
			start = mid + 1
		} else {
			end = mid - 1
		}
	}

	return result
}
