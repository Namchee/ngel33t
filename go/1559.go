package main

func detectCycle(x, y, px, py int, val byte, grid [][]byte, visited [][]bool) bool {
	visited[x][y] = true

	dx := []int{0, 0, -1, 1}
	dy := []int{1, -1, 0, 0}

	for i := 0; i < 4; i++ {
		nx, ny := x+dx[i], y+dy[i]

		if nx >= 0 && nx < len(grid) && ny >= 0 && ny < len(grid[0]) && grid[nx][ny] == val {
			if visited[nx][ny] {
				if nx != px || ny != py {
					return true
				}

				continue
			}

			if detectCycle(nx, ny, x, y, val, grid, visited) {
				return true
			}
		}
	}

	return false
}

func containsCycle(grid [][]byte) bool {
	n := len(grid)
	m := len(grid[0])

	visited := make([][]bool, n)
	for i := range visited {
		visited[i] = make([]bool, m)
	}

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			if !visited[i][j] {
				if detectCycle(i, j, -1, -1, grid[i][j], grid, visited) {
					return true
				}
			}

		}
	}

	return false
}
