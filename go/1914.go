package main

func smol(a, b int) int {
	if a > b {
		return b
	}

	return a
}

func rotateGrid2(grid [][]int, k int) [][]int {
	m := len(grid)
	n := len(grid[0])

	table := make([][]int, m)
	for i := 0; i < m; i++ {
		table[i] = make([]int, n)
	}

	directions := [][]int{
		[]int{1, 0},
		[]int{0, 1},
		[]int{-1, 0},
		[]int{0, -1},
	}

	for layer := 0; layer < smol(m, n)/2; layer++ {
		a := layer
		b := layer

		firstDir := 0
		secondDir := 0

		count := 2*(m+n-4*layer) - 4
		offset := k % count

		c := a
		d := b

		for offset > 0 {
			if c+directions[secondDir][0] < layer || c+directions[secondDir][0] >= m-layer || d+directions[secondDir][1] < layer || d+directions[secondDir][1] >= n-layer {
				secondDir = (secondDir + 1) % 4
			}

			c += directions[secondDir][0]
			d += directions[secondDir][1]

			offset--
		}

		for count > 0 {
			table[c][d] = grid[a][b]

			if c+directions[secondDir][0] < layer || c+directions[secondDir][0] >= m-layer || d+directions[secondDir][1] < layer || d+directions[secondDir][1] >= n-layer {
				secondDir = (secondDir + 1) % 4
			}

			if a+directions[firstDir][0] < layer || a+directions[firstDir][0] >= m-layer || b+directions[firstDir][1] < layer || b+directions[firstDir][1] >= n-layer {
				firstDir = (firstDir + 1) % 4
			}

			c += directions[secondDir][0]
			d += directions[secondDir][1]

			a += directions[firstDir][0]
			b += directions[firstDir][1]

			count--
		}
	}

	return table
}
