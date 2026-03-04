package main

func countZeroOnes(s string) (int, int) {
	zeros := 0
	for _, ch := range s {
		if ch == '0' {
			zeros++
		}
	}
	return zeros, len(s) - zeros
}

func findMaxForm(strs []string, m int, n int) int {
	table := make([][]int, m+1)
	for i := range table {
		table[i] = make([]int, n+1)
	}

	for _, s := range strs {
		zeros, ones := countZeroOnes(s)

		for i := m; i >= zeros; i-- {
			for j := n; j >= ones; j-- {
				if table[i-zeros][j-ones]+1 > table[i][j] {
					table[i][j] = table[i-zeros][j-ones] + 1
				}
			}
		}
	}

	return table[m][n]
}
