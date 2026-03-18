package main

func countSubmatrices(grid [][]int, k int) int {
	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[i]); j++ {
			if i > 0 {
				grid[i][j] += grid[i-1][j]
			}

			if j > 0 {
				grid[i][j] += grid[i][j-1]
			}

			if i > 0 && j > 0 {
				grid[i][j] -= grid[i-1][j-1]
			}
		}
	}

	result := 0

	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[i]); j++ {
			if grid[i][j] <= k {
				result++
			}
		}
	}

	return result
}
