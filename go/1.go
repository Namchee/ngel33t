package main

func twoSum(nums []int, target int) []int {
	mp := map[int]int{}

	for idx, val := range nums {
		mp[val] = idx
	}

	for idx, num := range nums {
		pair, ok := mp[target-num]

		if ok && pair != idx {
			return []int{idx, pair}
		}
	}

	return []int{}
}
