package main

func rotateTheBox(boxGrid [][]byte) [][]byte {
	m := len(boxGrid)
	n := len(boxGrid[0])

	mat := make([][]byte, n)
	for i := 0; i < n; i++ {
		mat[i] = make([]byte, m)
	}

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			mat[i][j] = boxGrid[m-1-j][i]
		}
	}

	for j := 0; j < m; j++ {
		lowest := n - 1
		for i := n - 1; i >= 0; i-- {
			if mat[i][j] == '*' {
				lowest = i - 1
			} else if mat[i][j] == '#' {
				mat[i][j] = '.'
				mat[lowest][j] = '#'
				lowest--
			}
		}
	}

	return mat
}
