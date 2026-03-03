package main

import (
	"strings"
)

func invert(s string) string {
	var sb strings.Builder

	for _, ch := range s {
		if ch == '0' {
			sb.WriteRune('1')
		} else {
			sb.WriteRune('0')
		}
	}

	return sb.String()
}

func reverse(s string) string {
	var sb strings.Builder
	idx := len(s) - 1

	for idx >= 0 {
		sb.WriteByte(s[idx])
		idx--
	}

	return sb.String()
}

func findKthBit(n int, k int) byte {
	table := []string{"0"}

	for len(table) < n {
		var sb strings.Builder

		last := table[len(table)-1]
		sb.WriteString(last)
		sb.WriteString("1")
		sb.WriteString(reverse(invert(last)))

		table = append(table, sb.String())
	}

	return table[len(table)-1][k-1]
}
