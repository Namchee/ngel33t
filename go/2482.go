package main

func onesMinusZeros(grid [][]int) [][]int {
	oneRows := make([]int, len(grid))
	oneCols := make([]int, len(grid[0]))

	for i := 0; i < len(grid); i++ {
		result := 0

		for j := 0; j < len(grid[i]); j++ {
			if grid[i][j] == 1 {
				result++
			}
		}

		oneRows[i] = result
	}

	for j := 0; j < len(grid[0]); j++ {
		result := 0

		for i := 0; i < len(grid); i++ {
			if grid[i][j] == 1 {
				result++
			}
		}

		oneCols[j] = result
	}

	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[i]); j++ {
			or := oneRows[i]
			oc := oneCols[j]
			zr := len(grid) - or
			zc := len(grid[0]) - oc

			grid[i][j] = or + oc - zr - zc
		}
	}

	return grid
}
