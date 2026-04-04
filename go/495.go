package main

func findDiagonalOrder(mat [][]int) []int {
	m, n := len(mat), len(mat[0])

	walker := [][]int{
		{-1, 1},
		{1, -1},
	}

	wIdx := 0
	x := 0
	y := 0

	result := []int{}

	for len(result) < len(mat)*len(mat[0]) {
		result = append(result, mat[x][y])

		x += walker[wIdx][0]
		y += walker[wIdx][1]

		if x < 0 || x >= m || y < 0 || y >= n {
			x -= walker[wIdx][0]
			y -= walker[wIdx][1]

			if wIdx == 0 {
				if y < n-1 {
					y++
				} else {
					x++
				}
			} else {
				if x < m-1 {
					x++
				} else {
					y++
				}
			}

			wIdx = 1 - wIdx
		}
	}

	return result
}
