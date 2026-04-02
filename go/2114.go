package main

import "strings"

func mostWordsFound(sentences []string) int {
	maxi := 0

	for _, sentence := range sentences {
		maxi = max(maxi, len(strings.Split(sentence, " ")))
	}

	return maxi
}
