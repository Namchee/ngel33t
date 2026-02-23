package main

import (
	"math"
	"strconv"
)

func hasAllCodes(s string, k int) bool {
	table := map[int]int{}

	for idx := 0; idx <= len(s)-k; idx++ {
		sub := s[idx : idx+k]
		val, _ := strconv.ParseInt(sub, 2, 32)

		ct, ok := table[int(val)]
		if ok {
			table[int(val)] = ct + 1
		} else {
			table[int(val)] = 1
		}
	}

	exp := math.Pow(2, float64(k))

	for val := 0; val < int(exp); val++ {
		_, ok := table[val]
		if !ok {
			return false
		}
	}

	return true
}
