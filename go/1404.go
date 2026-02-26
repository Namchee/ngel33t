package main

import "strings"

func isOne(s string) bool {
	for i := 0; i < len(s)-1; i++ {
		if s[i] != '0' {
			return false
		}
	}

	return s[len(s)-1] == '1'
}

func add(s string) string {
	tokens := strings.Split(s, "")
	carry := 1

	for i := len(tokens) - 1; i >= 0; i-- {
		if carry == 1 {
			if tokens[i] == "1" {
				tokens[i] = "0"
			} else {
				tokens[i] = "1"
				carry = 0
			}
		}
	}

	result := strings.Join(tokens, "")

	if carry == 1 {
		return "1" + result
	}

	return result
}

func divide(s string) string {
	tokens := strings.Split(s, "")

	for i := len(s) - 1; i > 0; i-- {
		tokens[i] = tokens[i-1]
	}

	tokens[0] = "0"

	return strings.Join(tokens, "")
}

func numSteps(s string) int {
	curr := s
	steps := 0

	for !isOne(curr) {
		last := curr[len(curr)-1]
		steps++

		if last == '1' {
			curr = add(curr)
		} else {
			curr = divide(curr)
		}

	}

	return steps
}
