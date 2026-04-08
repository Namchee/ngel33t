package main

import (
	"slices"
)

func maxGan(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func maxSumDistinctTriplet(x []int, y []int) int {
	mp := map[int]int{}

	for i := 0; i < len(x); i++ {
		v, ok := mp[x[i]]

		if !ok {
			mp[x[i]] = y[i]
		} else {
			mp[x[i]] = maxGan(v, y[i])
		}
	}

	if len(mp) < 3 {
		return -1
	}

	result := []int{}
	for _, v := range mp {
		result = append(result, v)
	}

	slices.Sort(result)

	return result[len(result)-1] + result[len(result)-2] + result[len(result)-3]
}
