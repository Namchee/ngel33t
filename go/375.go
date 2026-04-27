package main

func max(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func min(a, b int) int {
	if a > b {
		return b
	}

	return a
}

func getMoneyAmount(n int) int {
	table := make([][]int, n+1)
	for i := 0; i <= n; i++ {
		table[i] = make([]int, n+1)
	}

	for j := 2; j <= n; j++ {
		for i := j - 1; i > 0; i-- {
			mini := int(1e15)
			for k := i + 1; k < j; k++ {
				maximin := k + max(table[i][k-1], table[k+1][j])
				mini = min(mini, maximin)
			}

			if i+1 == j {
				table[i][j] = i
			} else {
				table[i][j] = mini
			}
		}
	}

	return table[1][n]
}
