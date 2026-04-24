package main

func numSplits(s string) int {
	result := 0
	left := make([]int, 26)
	right := make([]int, 26)

	disLeft := 0
	disRight := 0

	for _, c := range s {
		if right[c-'a'] == 0 {
			disRight++
		}
		right[c-'a']++
	}

	for _, c := range s {
		if left[c-'a'] == 0 {
			disLeft++
		}

		if right[c-'a'] == 1 {
			disRight--
		}

		left[c-'a']++
		right[c-'a']--

		if disLeft == disRight {
			result++
		}
	}

	return result
}
