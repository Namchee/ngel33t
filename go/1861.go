package main

import "fmt"

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

	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			fmt.Printf("%c ", mat[i][j])
		}
		fmt.Print("\n")
	}

	for j := 0; j < m; j++ {
		for i := n - 1; i >= 0; i-- {
			if mat[i][j] == '#' {
				k := i
				for k+1 < n && mat[k+1][j] != '*' && mat[k+1][j] != '#' {
					k++
				}

				mat[i][j] = '.'
				mat[k][j] = '#'
			}
		}
	}

	return mat
}
