package main

import "strings"

func isValidSerialization(preorder string) bool {
	tokens := strings.Split(preorder, ",")

	slots := 1

	for _, token := range tokens {
		slots -= 1
		if slots < 0 {
			return false
		}

		if token != "#" {
			slots += 2
		}
	}

	return slots == 0
}
