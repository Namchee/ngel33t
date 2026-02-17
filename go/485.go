package main

func findMaxConsecutiveOnes(nums []int) int {
	result := 0
	ct := 0

	for _, val := range nums {
		if val == 1 {
			ct += 1
		} else {
			result = max(result, ct)
			ct = 0
		}
	}

	return max(result, ct)
}
