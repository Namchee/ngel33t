package main

const MatrixMod = 12345

func constructProductMatrix(grid [][]int) [][]int {
	n := len(grid)
	m := len(grid[0])
	result := make([][]int, n)
	for i := range result {
		result[i] = make([]int, m)
	}

	prefix := 1
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			result[i][j] = prefix

			prefix = (prefix * grid[i][j]) % MatrixMod
		}
	}

	suffix := 1
	for i := n - 1; i >= 0; i-- {
		for j := m - 1; j >= 0; j-- {
			result[i][j] = (result[i][j] * suffix) % MatrixMod

			suffix = (suffix * grid[i][j]) % MatrixMod
		}
	}

	return result
}
