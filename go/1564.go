package main

func maxNonOverlapping(nums []int, target int) int {
	mp := map[int]int{}
	mp[0] = -1

	prefix := 0
	right := -1
	count := 0

	for i := 0; i < len(nums); i++ {
		prefix += nums[i]
		val, ok := mp[prefix-target]
		if ok && right <= val {
			count++
			right = i
		}

		mp[prefix] = i
	}

	return count
}
