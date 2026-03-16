package main

type PairSpiral struct {
	x int
	y int
}

func generateMatrix(n int) [][]int {
	result := make([][]int, n)
	for idx := range len(result) {
		result[idx] = make([]int, n)
	}

	walker := []PairSpiral{
		PairSpiral{0, 1},
		PairSpiral{1, 0},
		PairSpiral{0, -1},
		PairSpiral{-1, 0},
	}

	x := 0
	y := 0

	all := n * n

	idx := 1
	w := 0

	for idx <= all {
		result[x][y] = idx

		if x+walker[w].x < 0 || y+walker[w].y < 0 || x+walker[w].x >= n || y+walker[w].y >= n || result[x+walker[w].x][y+walker[w].y] != 0 {
			w = (w + 1) % 4
		}

		x += walker[w].x
		y += walker[w].y

		idx++
	}

	return result
}
