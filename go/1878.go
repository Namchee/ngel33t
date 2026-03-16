package main

import "slices"

func getBiggestThree(grid [][]int) []int {
	result := map[int]bool{}
	walker := [][]int{
		[]int{-1, 1},
		[]int{1, 1},
		[]int{1, -1},
		[]int{-1, -1},
	}

	for sz := 0; sz <= len(grid)/2; sz++ {
		for i := sz; i < len(grid)-sz; i++ {
			for j := 0; j < len(grid[i])-(2*sz); j++ {
				temp := grid[i][j]

				k := i
				l := j

				for _, mt := range walker {
					for ct := 0; ct < sz; ct++ {
						temp += grid[k][l]

						k += mt[0]
						l += mt[1]
					}
				}

				if sz > 0 {
					temp -= grid[i][j]
				}

				result[temp] = true
			}
		}
	}

	keys := make([]int, 0, len(result))
	for k := range result {
		keys = append(keys, k)
	}

	slices.SortFunc(keys, func(a, b int) int {
		return b - a
	})

	limit := 3
	if len(keys) < limit {
		limit = len(keys)
	}

	return keys[:limit]
}
