package main

import (
	"math"
	"slices"
	"strconv"
	"strings"
)

func getMinutes(str string) int {
	tokens := strings.Split(str, ":")

	hour, _ := strconv.Atoi(tokens[0])
	hour *= 60

	minutes, _ := strconv.Atoi(tokens[1])

	return minutes + hour
}

func findMinDifference(timePoints []string) int {
	result := math.MaxInt32

	m := []int{}
	for _, p := range timePoints {
		m = append(m, getMinutes(p))
	}

	slices.Sort(m)

	for i := 1; i < len(timePoints); i++ {
		result = min(result, m[i]-m[i-1])
	}

	return min(result, 24*60-m[len(m)-1]+m[0])
}
