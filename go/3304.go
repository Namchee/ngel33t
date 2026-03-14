package main

import "strings"

func kthCharacter(k int) byte {
	word := "a"
	letters := "abcdefghijklmnopqrstuvwxyz"
	var sb strings.Builder

	for len(word) < k {
		for _, ch := range word {
			sb.WriteRune(ch)
		}

		for _, ch := range word {
			sb.WriteByte(letters[((ch-'a')+1)%26])
		}

		word = sb.String()
		sb.Reset()
	}

	return word[k-1]
}
