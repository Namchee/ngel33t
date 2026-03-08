package main

import "strings"

func findDifferentBinaryString(nums []string) string {
	var sb strings.Builder

	for i := 0; i < len(nums); i++ {
		if nums[i][i] == '0' {
			sb.WriteByte('1')
		} else {
			sb.WriteByte('0')
		}
	}

	return sb.String()
}
