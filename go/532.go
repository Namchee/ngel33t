package main

func findPairs(nums []int, k int) int {
	if k < 0 {
		return 0
	}

	count := 0
	mp := make(map[int]int)

	for _, num := range nums {
		mp[num]++
	}

	for num, freq := range mp {
		if k == 0 {
			if freq >= 2 {
				count++
			}
		} else {
			if _, ok := mp[num+k]; ok {
				count++
			}
		}
	}

	return count
}
