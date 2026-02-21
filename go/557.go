package main

import "strings"

func reverseWords(s string) string {
	tokens := strings.Split(s, " ")

	for idx, token := range tokens {
		var sb strings.Builder
		for idx := len(token) - 1; idx >= 0; idx-- {
			sb.WriteByte(token[idx])
		}

		tokens[idx] = sb.String()
	}

	return strings.Join(tokens, " ")
}
