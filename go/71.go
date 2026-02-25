package main

import (
	"regexp"
	"strings"
)

func simplifyPath(path string) string {
	tokens := regexp.MustCompile("/+").Split(path, -1)
	container := []string{}

	for _, token := range tokens {
		if token == "." || token == "" {
			continue
		}

		if token == ".." {
			if len(container) > 0 {
				container = container[:len(container)-1]
			}
		} else {
			container = append(container, token)
		}
	}

	return "/" + strings.Join(container, "/")
}
