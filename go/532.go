package main

import (
	"slices"
)

func findPairs(nums []int, k int) int {
	result := 0
	mp := map[int]int{}
	used := map[int]bool{}

	slices.Sort(nums)

	for _, num := range nums {
		mp[num]++
	}

	if k == 0 {
		keys := make([]int, 0, len(mp))
		for k2 := range mp {
			keys = append(keys, k2)
		}

		for _, key := range keys {
			freq := mp[key]

			result += freq / 2
		}
	} else {
		for _, num := range nums {
			_, use := used[num]
			if use {
				continue
			}

			lt := num - k
			_, ok := mp[lt]
			_, u := used[lt]
			if ok && !u {
				result++
				used[lt] = true
			}

			gt := num + k
			_, ok = mp[gt]
			if ok {
				result++
				used[num] = true
			}
		}
	}

	return result
}
