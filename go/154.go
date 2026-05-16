package main

func findMinDupeMin(a, b int) int {
	if a > b {
		return b
	}

	return a
}

func findMinDupe(nums []int) int {
	result := nums[0]
	start := 0
	end := len(nums) - 1

	for start <= end {
		if nums[start] < nums[end] {
			result = findMinDupeMin(result, nums[start])
			break
		}

		mid := start + (end-start)/2
		result = findMinDupeMin(nums[mid], result)

		if nums[start] == nums[mid] && nums[mid] == nums[end] {
			start++
			end--
			continue
		}

		if nums[mid] >= nums[start] {
			start = mid + 1
		} else {
			end = mid - 1
		}
	}

	return result
}
