package main

func rotateGrid(grid [][]int) [][]int {
	m := len(grid)
	n := len(grid[0])

	container := make([][]int, n)
	for i := range container {
		container[i] = make([]int, m)
	}

	// transpose
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			container[j][m-1-i] = grid[i][j]
		}
	}

	return container
}

func canPartitionGrid2(grid [][]int) bool {
	var total int64 = 0
	m := len(grid)
	n := len(grid[0])

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			total += int64(grid[i][j])
		}
	}

	for k := 0; k < 4; k++ {
		exist := make(map[int64]bool)
		exist[0] = true

		var sum int64 = 0
		m = len(grid)
		n = len(grid[0])

		if m < 2 {
			grid = rotateGrid(grid)
			continue
		}

		if n == 1 {
			for i := 0; i < m-1; i++ {
				sum += int64(grid[i][0])
				tag := sum*2 - total

				if tag == 0 || tag == int64(grid[0][0]) || tag == int64(grid[i][0]) {
					return true
				}
			}

			grid = rotateGrid(grid)
			continue
		}

		for i := 0; i < m-1; i++ {
			for j := 0; j < n; j++ {
				exist[int64(grid[i][j])] = true
				sum += int64(grid[i][j])
			}

			tag := sum*2 - total

			if i == 0 {
				if tag == 0 || tag == int64(grid[0][0]) || tag == int64(grid[0][n-1]) {
					return true
				}

				continue
			}

			if exist[tag] {
				return true
			}
		}

		grid = rotateGrid(grid)
	}

	return false
}
