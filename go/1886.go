package main

func rotateMatrix(mat [][]int) [][]int {
	for layer := 0; layer < len(mat)/2; layer++ {
		first := layer
		last := len(mat) - 1 - layer

		for i := first; i < last; i++ {
			offset := i - first

			temp := mat[first][i]

			mat[first][i] = mat[last-offset][first]
			mat[last-offset][first] = mat[last][last-offset]
			mat[last][last-offset] = mat[i][last]
			mat[first][i] = temp
		}
	}

	return mat
}

func isEqualMatrix(mat [][]int, target [][]int) bool {
	flag := true

	for i := 0; i < len(mat) && flag; i++ {
		for j := 0; j < len(mat[i]) && flag; j++ {
			if mat[i][j] != target[i][j] {
				flag = false
			}
		}
	}

	return flag
}

func findRotation(mat [][]int, target [][]int) bool {
	if isEqualMatrix(mat, target) {
		return true
	}

	for ct := 0; ct < 3; ct++ {
		rotated := rotateMatrix(mat)

		if isEqualMatrix(rotated, target) {
			return true
		}
	}

	return false
}
