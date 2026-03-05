package main

import "strings"

func minOperations(s string) int {
	oneFirst := ""

	var sb strings.Builder

	for i := 0; i < len(s); i++ {
		if i%2 == 0 {
			sb.WriteRune('1')
		} else {
			sb.WriteRune('0')
		}
	}

	oneFirst = sb.String()

	a := 0
	b := 0

	for idx, ch := range s {
		if byte(ch) != oneFirst[idx] {
			a++
		} else {
			b++
		}
	}

	return min(a, b)
}
