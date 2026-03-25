package main

func canPartitionGrid(grid [][]int) bool {
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

	// horizontal split
	for i := 0; i < len(grid)-1; i++ {
		a := grid[i][len(grid[0])-1]
		b := grid[len(grid)-1][len(grid[0])-1] - a

		if a == b {
			return true
		}
	}

	// vertical split
	for i := 0; i < len(grid[0])-1; i++ {
		a := grid[len(grid)-1][i]
		b := grid[len(grid)-1][len(grid[0])-1] - a

		if a == b {
			return true
		}
	}

	return false
}
