package main

func findTheString(lcp [][]int) string {
	n := len(lcp)
	s := make([]byte, n)
	for i := 0; i < n; i++ {
		s[i] = 'X'
	}
	id := -1

	for i := 0; i < n; i++ {
		if lcp[i][i] != n-i {
			return ""
		}

		if s[i] >= 'a' {
			continue
		}

		isIdgte25 := id >= 25
		id++

		if isIdgte25 {
			return ""
		}

		for j := i; j < n; j++ {
			if lcp[i][j] > 0 {
				s[j] = byte('a' + id)
			}
		}
	}

	for i := 0; i < n; i++ {
		for j := 0; j < i; j++ {
			x := lcp[i][j]
			if x != lcp[j][i] || x+i > n {
				return ""
			}

			y := 0
			if i < n-1 {
				y = lcp[i+1][j+1]
			}

			if s[i] == s[j] {
				y++
			} else {
				y = 0
			}

			if x != y {
				return ""
			}
		}
	}

	return string(s)
}
