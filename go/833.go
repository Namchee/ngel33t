package main

import (
	"strings"
)

type Replacement struct {
	source string
	target string
}

func findReplaceString(s string, indices []int, sources []string, targets []string) string {
	mp := make(map[int]Replacement)

	for i := 0; i < len(indices); i++ {
		idx := indices[i]
		src := sources[i]

		if idx+len(src) <= len(s) && s[idx:idx+len(src)] == src {
			mp[idx] = Replacement{src, targets[i]}
		}
	}

	var sb strings.Builder
	for i := 0; i < len(s); {
		if val, ok := mp[i]; ok {
			sb.WriteString(val.target)
			i += len(val.source)
		} else {
			sb.WriteByte(s[i])
			i++
		}
	}

	return sb.String()
}
