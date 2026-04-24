package main

func countCompleteSubarrays(nums []int) int {
	freq := map[int]bool{}

	for _, num := range nums {
		freq[num] = true
	}

	result := 0
	target := len(freq)

	for i := 0; i < len(nums); i++ {
		mp := map[int]bool{}

		for j := i; j < len(nums); j++ {
			mp[nums[j]] = true

			if len(mp) == target {
				result++
			}
		}
	}

	return result
}
