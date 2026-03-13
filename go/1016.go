package main

import (
	"strconv"
	"strings"
)

func queryString(s string, n int) bool {
	for i := 1; i <= n; i++ {
		binary := strconv.FormatInt(int64(i), 2)

		if !strings.Contains(s, binary) {
			return false
		}
	}

	return true
}
