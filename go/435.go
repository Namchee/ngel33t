package main

import (
	"sort"
)

func eraseOverlapIntervals(intervals [][]int) int {
	result := 0

	sort.Slice(intervals, func(i, j int) bool {
		a := intervals[i]
		b := intervals[j]

		if a[0] != b[0] {
			return a[0] < b[0]
		}

		return a[1] < b[1]
	})

	right := intervals[0][1]

	for i := 1; i < len(intervals); i++ {
		if intervals[i][0] < right {
			result++
		} else {
			right = intervals[i][1]
		}
	}

	return result
}
