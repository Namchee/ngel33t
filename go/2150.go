package main

func findLonely(nums []int) []int {
	result := []int{}

	mp := map[int]int{}
	for _, num := range nums {
		mp[num]++
	}

	for key, val := range mp {
		_, left := mp[key-1]
		_, right := mp[key+1]

		if val == 1 && !left && !right {
			result = append(result, key)
		}
	}

	return result
}
