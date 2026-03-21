package main

func reverseSubmatrix(grid [][]int, x int, y int, k int) [][]int {
	for i := 0; i < k/2; i++ {
		a := x + i
		b := x + k - 1 - i

		for j := 0; j < k; j++ {
			col := y + j
			grid[a][col], grid[b][col] = grid[b][col], grid[a][col]
		}
	}

	return grid
}
