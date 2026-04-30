package main

func greater(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func maxPathScore(grid [][]int, k int) int {
	table := make([][][]int, len(grid))
	for i := 0; i < len(grid); i++ {
		table[i] = make([][]int, len(grid[i]))
		for j := range table[i] {
			table[i][j] = make([]int, k+1)

			for c := 0; c <= k; c++ {
				table[i][j][c] = -1
			}
		}
	}

	startCost := 0
	if grid[0][0] > 0 {
		startCost = 1
	}
	if startCost <= k {
		table[0][0][startCost] = grid[0][0]
	}

	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[i]); j++ {
			cost := 0
			if grid[i][j] > 0 {
				cost = 1
			}

			// from top
			if i > 0 {
				for c := 0; c <= k; c++ {
					if cost+c <= k {
						table[i][j][cost+c] = greater(table[i][j][cost+c], table[i-1][j][c]+grid[i][j])
					}
				}
			}

			// from left
			if j > 0 {
				for c := 0; c <= k; c++ {
					if cost+c <= k {
						table[i][j][cost+c] = greater(table[i][j][cost+c], table[i][j-1][c]+grid[i][j])
					}
				}
			}
		}
	}

	best := -1
	target := table[len(grid)-1][len(grid[0])-1]

	for i := 0; i <= k; i++ {
		best = greater(best, target[i])
	}

	return best
}
