package main

import "strings"

func replaceDigits(s string) string {
	letters := "abcdefghijklmnopqrstuvwxyz"

	var sb strings.Builder
	var prev byte

	for i := 0; i < len(s); i++ {
		ch := s[i]
		var el byte

		if i%2 == 0 {
			prev = ch - 'a'
			el = ch
		} else {
			shift := ch - '0'
			el = letters[(prev+shift)%26]
		}

		sb.WriteByte(el)
	}

	return sb.String()
}
