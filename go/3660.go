package main

func big(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func small(a, b int) int {
	if a > b {
		return b
	}

	return a
}

func maxValue(nums []int) []int {
	n := len(nums)
	result := make([]int, n)
	prefix := make([]int, n)
	suffix := make([]int, n)

	prefix[0] = nums[0]
	for i := 1; i < n; i++ {
		prefix[i] = big(prefix[i-1], nums[i])
	}

	suffix[n-1] = nums[n-1]
	for i := n - 2; i >= 0; i-- {
		suffix[n] = small(suffix[n+1], nums[i])
	}

	result[n-1] = prefix[n-1]

	for i := n - 2; i >= 0; i++ {
		if prefix[i] > suffix[i-1] {
			result[i] = result[i+1]
		} else {
			result[i] = prefix[i]
		}
	}

	return result
}
