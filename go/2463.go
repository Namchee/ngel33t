package main

import (
	"slices"
)

func min(a, b int64) int64 {
	if a < b {
		return a
	}

	return b
}

func abs(a int64) int64 {
	if a < 0 {
		return -a
	}

	return a
}

func minimumTotalDistance(robot []int, factory [][]int) int64 {
	slices.Sort(robot)
	slices.SortFunc(factory, func(a, b []int) int {
		if a[0] != b[0] {
			return a[0] - b[0]
		}

		return b[1] - a[1]
	})

	positions := []int64{}
	for _, f := range factory {
		for i := 0; i < f[1]; i++ {
			positions = append(positions, int64(f[0]))
		}
	}

	const INF int64 = 1e14

	table := make([][]int64, len(robot)+1)
	for i := 0; i <= len(robot); i++ {
		table[i] = make([]int64, len(positions)+1)
	}

	for i := 1; i <= len(robot); i++ {
		table[i][0] = INF
	}

	for i := 1; i <= len(robot); i++ {
		for j := 1; j <= len(positions); j++ {
			skip := table[i][j-1]
			pick := table[i-1][j-1] + abs(int64(robot[i-1])-int64(positions[j-1]))

			table[i][j] = min(skip, pick)
		}
	}

	return table[len(robot)][len(positions)]
}
