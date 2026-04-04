package main

import (
	"strings"
)

func decodeCiphertext(encodedText string, rows int) string {
	table := []string{}

	var sb strings.Builder

	le := len(encodedText) / rows
	for i := 0; i < rows; i++ {
		for j := 0; j < le; j++ {
			sb.WriteByte(encodedText[i*le+j])
		}

		table = append(table, sb.String())
		sb.Reset()
	}

	for i := 0; i < le; i++ {
		for j := 0; j < rows; j++ {
			if j >= rows || j+i >= le {
				break
			}

			sb.WriteByte(table[j][j+i])
		}
	}

	return strings.TrimRight(sb.String(), " ")
}
