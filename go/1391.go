package main

var startdirs = [6]uint8{1, 2, 2, 2, 0, 1}

var nextpos = [5][2]int{
	{500, 500},
	{0, 1},
	{1, 0},
	{0, -1},
	{-1, 0},
}

var states = [5][7]uint8{
	{0, 0, 0, 0, 0, 0, 0},
	{0, 1, 0, 2, 0, 4, 0},
	{0, 0, 2, 0, 0, 3, 1},
	{0, 3, 0, 0, 2, 0, 4},
	{0, 0, 4, 3, 1, 0, 0},
}

func move(dir uint8, i, j, street int) (uint8, int, int) {
	ndir := states[dir][street]
	ni := i + nextpos[ndir][0]
	nj := j + nextpos[ndir][1]

	return ndir, ni, nj
}

func inBounds(i, j, m, n int) bool {
	return i >= 0 && i < m && j >= 0 && j < n
}

func inTarget(i, j, m, n int) bool {
	return i == m-1 && j == n-1

}

func hasValidPath(grid [][]int) bool {
	m := len(grid)
	n := len(grid[0])
	extra := grid[0][0] == 4
	target := grid[m-1][n-1]

	simulate := func(dir uint8, i, j int) bool {
		grid[m-1][n-1] = target
		for inBounds(i, j, m, n) && !inTarget(i, j, m, n) {
			street := grid[i][j]
			grid[i][j] = 0
			dir, i, j = move(dir, i, j, street)
		}

		return inTarget(i, j, m, n) && (extra || states[dir][grid[i][j]] != 0)
	}

	dir := startdirs[grid[0][0]-1]
	i := nextpos[dir][0]
	j := nextpos[dir][1]

	return m*n == 1 || simulate(dir, i, j) || extra && simulate(1, 0, 0)
}
