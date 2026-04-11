package main

import (
	"regexp"
	"strings"
)

func removeComments(source []string) []string {
	actual := strings.Join(source, "\n")
	re := regexp.MustCompile("//.*|/\\*[\\s\\S]*?\\*/")

	actual = re.ReplaceAllString(actual, "")

	lines := strings.Split(actual, "\n")
	result := []string{}

	for _, line := range lines {
		if line == "" && !strings.Contains(actual, line) {
			continue
		}

		if len(line) == 0 {
			continue
		}

		result = append(result, line)
	}

	return result
}
