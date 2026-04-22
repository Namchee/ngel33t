package main

import (
	"sort"
)

type Entry struct {
	val int
	idx int
}

func lexicographicallySmallestArray(nums []int, limit int) []int {
	n := len(nums)
	pairs := make([]Entry, n)
	for i, v := range nums {
		pairs[i] = Entry{val: v, idx: i}
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].val < pairs[j].val
	})

	result := make([]int, n)

	i := 0
	for i < n {
		j := i + 1

		for j < n && pairs[j].val-pairs[j-1].val <= limit {
			j++
		}

		groupIndices := make([]int, j-i)
		for k := i; k < j; k++ {
			groupIndices[k-i] = pairs[k].idx
		}
		sort.Ints(groupIndices)

		for k := i; k < j; k++ {
			result[groupIndices[k-i]] = pairs[k].val
		}

		i = j
	}

	return result
}
