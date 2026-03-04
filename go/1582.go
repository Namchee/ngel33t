package main

func isSpecial(i int, j int, mat [][]int) bool {
	for x := 0; x < len(mat); x++ {
		if x != i && mat[x][j] == 1 {
			return false
		}
	}

	for y := 0; y < len(mat[i]); y++ {
		if y != j && mat[i][y] == 1 {
			return false
		}
	}

	return true
}

func numSpecial(mat [][]int) int {
	result := 0

	for i := 0; i < len(mat); i++ {
		for j := 0; j < len(mat[i]); j++ {
			if mat[i][j] == 1 && isSpecial(i, j, mat) {
				result++
			}
		}
	}

	return result
}
