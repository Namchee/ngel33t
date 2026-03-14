package main

import "slices"

func vowelStrings(words []string, left int, right int) int {
	count := 0

	vowels := []byte{'a', 'i', 'u', 'e', 'o'}

	for i := left; i <= right; i++ {
		if slices.Contains(vowels, words[i][0]) && slices.Contains(vowels, words[i][len(words[i])-1]) {
			count++
		}
	}

	return count
}
