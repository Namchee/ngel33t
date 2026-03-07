package main

func integerBreak(n int) int {
	table := []int{0, 1, 1, 2, 4, 6, 9}
	ct := 7

	for ct <= n {
		table = append(table, max(table[ct-3]*3, table[ct-2]*2))
		ct++
	}

	return table[n]
}
