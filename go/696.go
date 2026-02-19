package main

func countBinarySubstrings(s string) int {
	result, prev, curr := 0, 0, 1
	for i := 1; i < len(s); i++ {
		if s[i-1] != s[i] {
			result += min(prev, curr)
			prev = curr
			curr = 1
		} else {
			curr++
		}
	}

	return result
}
