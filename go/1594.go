package main

import (
	"math"
)

const ProductMod = 1000000007

func maxProductPath(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	result := -1
	matrix := make([][][]int, m)
	for i := 0; i < m; i++ {
		matrix[i] = make([][]int, n)
	}

	matrix[0][0] = []int{grid[0][0], grid[0][0]}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			a := math.MinInt32
			b := math.MaxInt32

			// from the top lane
			if i > 0 {
				a = max(a, (grid[i][j] * matrix[i-1][j][0]), (grid[i][j] * matrix[i-1][j][1]))
				b = min(b, (grid[i][j] * matrix[i-1][j][0]), (grid[i][j] * matrix[i-1][j][1]))
			}

			// from the left lane
			if j > 0 {
				a = max(a, (grid[i][j] * matrix[i][j-1][0]), (grid[i][j] * matrix[i][j-1][1]))
				b = min(b, (grid[i][j] * matrix[i][j-1][0]), (grid[i][j] * matrix[i][j-1][1]))
			}

			if len(matrix[i][j]) == 0 {
				matrix[i][j] = []int{a, b}
			}
		}
	}

	return max(result, matrix[m-1][n-1][0]%ProductMod, matrix[m-1][n-1][1]%ProductMod)
}
