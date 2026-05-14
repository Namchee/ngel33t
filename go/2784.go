package main

func numBeeg(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func isGood(nums []int) bool {
	maxi := nums[0]

	for i := 1; i < len(nums); i++ {
		maxi = numBeeg(nums[i], maxi)
	}

	if len(nums) < maxi+1 {
		return false
	}

	freq := make([]int, maxi+1)
	for i := 0; i < len(nums); i++ {
		freq[nums[i]]++
	}

	for i := 1; i < maxi; i++ {
		if freq[i] != 1 {
			return false
		}
	}

	return freq[maxi] == 2
}
