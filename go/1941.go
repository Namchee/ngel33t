package main

func areOccurrencesEqual(s string) bool {
	freq := make([]int, 26)

	for _, ch := range s {
		freq[ch-'a']++
	}

	base := -1

	for _, f := range freq {
		if f > 0 {
			if base == -1 {
				base = f
				continue
			}

			if f != base {
				return false
			}
		}
	}

	return true
}
