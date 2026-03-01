package main

import (
	"strconv"
	"strings"
)

func generateLetterCase(idx int, tokens []string, result *[]string) {
	if idx >= len(tokens) {
		*result = append(*result, strings.Join(tokens, ""))
		return
	}

	if _, err := strconv.Atoi(tokens[idx]); err == nil {
		generateLetterCase(idx+1, tokens, result)
	} else {
		tokens[idx] = strings.ToUpper(tokens[idx])
		generateLetterCase(idx+1, tokens, result)
		tokens[idx] = strings.ToLower(tokens[idx])
		generateLetterCase(idx+1, tokens, result)
	}
}

func letterCasePermutation(s string) []string {
	result := []string{}
	tokens := strings.Split(s, "")

	generateLetterCase(0, tokens, &result)

	return result
}
