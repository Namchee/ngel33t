package main

import (
	"slices"
)

func sortByBits(arr []int) []int {
	bits := map[int][]int{}

	slices.Sort(arr)

	for _, num := range arr {
		temp := num
		ct := 0

		for temp > 0 {
			ct += temp & 1
			temp >>= 1
		}

		_, ok := bits[ct]
		if !ok {
			bits[ct] = []int{}
		}

		bits[ct] = append(bits[ct], num)
	}

	keys := make([]int, 0, len(bits))
	for k := range bits {
		keys = append(keys, k)
	}

	slices.Sort(keys)

	result := []int{}
	for _, key := range keys {
		for _, num := range bits[key] {
			result = append(result, num)
		}
	}

	return result
}
