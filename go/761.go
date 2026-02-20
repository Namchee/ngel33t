package main

import (
	"slices"
	"strings"
)

func makeLargestSpecial(s string) string {
	if len(s) == 0 {
		return ""
	}

	buffer := []string{}
	balance := 0
	start := 0

	for idx, chr := range s {
		if chr == '1' {
			balance++
		} else {
			balance--
		}

		if balance == 0 {
			temp := "1" + makeLargestSpecial(s[start+1:idx]) + "0"
			buffer = append(buffer, temp)
			start = idx + 1
		}
	}

	slices.SortFunc(buffer, func(a, b string) int {
		if a+b > b+a {
			return -1
		}

		return 1
	})

	return strings.Join(buffer, "")
}
