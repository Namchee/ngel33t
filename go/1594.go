package main

import "math"

const ProductMod = 1_000_000_007

func maxProductPath(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	matrix := make([][][]int64, m)
	for i := 0; i < m; i++ {
		matrix[i] = make([][]int64, n)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if i == 0 && j == 0 {
				matrix[i][j] = []int64{int64(grid[i][j]), int64(grid[i][j])}
				continue
			}

			var curMax int64 = math.MinInt64
			var curMin int64 = math.MaxInt64

			if i > 0 {
				v1 := int64(grid[i][j]) * matrix[i-1][j][0]
				v2 := int64(grid[i][j]) * matrix[i-1][j][1]
				curMax = max(curMax, v1, v2)
				curMin = min(curMin, v1, v2)
			}

			if j > 0 {
				v1 := int64(grid[i][j]) * matrix[i][j-1][0]
				v2 := int64(grid[i][j]) * matrix[i][j-1][1]
				curMax = max(curMax, v1, v2)
				curMin = min(curMin, v1, v2)
			}

			matrix[i][j] = []int64{curMax, curMin}
		}
	}

	result := matrix[m-1][n-1][0]

	if result < 0 {
		return -1
	}

	return int(result % ProductMod)
}
