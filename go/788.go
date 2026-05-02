package main

func rotatedDigits(n int) int {
	table := make([]int, n+1)
	result := 0

	for i := 0; i <= n; i++ {
		if i < 10 {
			if i == 0 || i == 1 || i == 8 {
				table[i] = 1
			} else if i == 2 || i == 5 || i == 6 || i == 9 {
				table[i] = 2
				result++
			} else {
				table[i] = 0
			}
		} else {
			prefix := table[i/10]
			last := table[i%10]

			if prefix == 1 && last == 1 {
				table[i] = 1
			} else if prefix > 1 && last > 1 {
				table[i] = 2
				result++
			} else {
				table[i] = 0
			}
		}
	}

	return result
}
