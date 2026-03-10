package main

func matrixBlockSum(mat [][]int, k int) [][]int {
	answer := make([][]int, len(mat))
	for i := 0; i < len(mat); i++ {
		answer[i] = make([]int, len(mat[i]))
	}

	for i := 0; i < len(mat); i++ {
		for j := 0; j < len(mat[i]); j++ {
			val := mat[i][j]

			if i > 0 {
				val += mat[i-1][j]
			}

			if j > 0 {
				val += mat[i][j-1]
			}

			if i > 0 && j > 0 {
				val -= mat[i-1][j-1]
			}

			mat[i][j] = val
		}
	}

	for i := 0; i < len(mat); i++ {
		for j := 0; j < len(mat[i]); j++ {
			a := i - k - 1
			b := j - k - 1
			c := i + k
			d := j + k

			if c >= len(mat) {
				c = len(mat) - 1
			}

			if d >= len(mat[i]) {
				d = len(mat[i]) - 1
			}

			val := mat[c][d]

			if a >= 0 {
				val -= mat[a][d]
			}

			if b >= 0 {
				val -= mat[c][b]
			}

			if a >= 0 && b >= 0 {
				val += mat[a][b]
			}

			answer[i][j] = val
		}
	}

	return answer
}
