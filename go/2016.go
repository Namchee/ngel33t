package main

func maxim(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func minim(a, b int) int {
	if a > b {
		return b
	}

	return a
}

func maximumDifference(nums []int) int {
	minimum := nums[0]
	result := -1

	for i := 1; i < len(nums); i++ {
		if nums[i] > minimum {
			result = maxim(result, nums[i]-minimum)
		}
		minimum = minim(minimum, nums[i])
	}

	return result
}
