package main

func permute(idx int, n int, used map[int]bool) int {
	if idx > n {
		return 1
	}

	sum := 0
	for i := 1; i <= n; i++ {
		_, ok := used[i]

		if (idx%i == 0 || i%idx == 0) && !ok {
			used[i] = true
			sum += permute(idx+1, n, used)

			delete(used, i)
		}
	}

	return sum
}

func countArrangement(n int) int {
	return permute(1, n, map[int]bool{})
}
