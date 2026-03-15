package main

type Pair struct {
	x int
	y int
}

func spiralOrder(matrix [][]int) []int {
	all := len(matrix) * len(matrix[0])
	result := make([]int, all)

	walker := []Pair{
		Pair{0, 1},
		Pair{1, 0},
		Pair{0, -1},
		Pair{-1, 0},
	}

	x := 0
	y := 0

	idx := 0
	w := 0

	for idx < all {
		result[idx] = matrix[x][y]
		matrix[x][y] = -101

		if x+walker[w].x < 0 || y+walker[w].y < 0 || x+walker[w].x >= len(matrix) || y+walker[w].y >= len(matrix[0]) || matrix[x+walker[w].x][y+walker[w].y] == -101 {
			w = (w + 1) % 4
		}

		x += walker[w].x
		y += walker[w].y

		idx++
	}

	return result
}
