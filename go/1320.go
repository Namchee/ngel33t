package main

import "math"

func letterDistance(a int, b int) int {
	first := a/6 - b/6
	second := a%6 - b%6

	if first < 0 {
		first *= -1
	}

	if second < 0 {
		second *= -1
	}

	return first + second
}

func minimumDistance2F(word string) int {
	n := len(word)
	// n-th word, from letter X to letter Y
	table := make([][][]int, n)
	for i := 0; i < n; i++ {
		table[i] = make([][]int, 26)

		for j := 0; j < 26; j++ {
			table[i][j] = make([]int, 26)
			for k := 0; k < 26; k++ {
				table[i][j][k] = math.MaxInt
			}
		}
	}

	first := int(word[0] - 'A')
	for k := 0; k < 26; k++ {
		table[0][first][k] = 0
		table[0][k][first] = 0
	}

	for i := 1; i < n; i++ {
		curr := int(word[i] - 'A')

		for j := 0; j < 26; j++ {
			for k := 0; k < 26; k++ {
				if table[i-1][j][k] == math.MaxInt {
					continue
				}

				table[i][j][curr] = min(table[i][j][curr], table[i-1][j][k]+letterDistance(k, curr))
				table[i][curr][k] = min(table[i][curr][k], table[i-1][j][k]+letterDistance(curr, j))
			}
		}
	}

	best := math.MaxInt

	for i := 0; i < 26; i++ {
		for j := 0; j < 26; j++ {
			best = min(best, table[n-1][i][j])
		}
	}

	return best
}
