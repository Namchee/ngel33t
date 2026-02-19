package main

import "sort"

func minimumAbsDifference(arr []int) [][]int {
	sort.Ints(arr)

	best := arr[len(arr)-1] - arr[0]
	result := [][]int{}
	for i := 1; i < len(arr); i++ {
		diff := arr[i] - arr[i-1]
		if diff == best {
			result = append(result, []int{arr[i-1], arr[i]})
		} else if diff < best {
			result = [][]int{{arr[i-1], arr[i]}}
			best = diff
		}
	}

	return result
}
