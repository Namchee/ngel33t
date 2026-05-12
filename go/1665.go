package main

import "slices"

func minimumEffort(tasks [][]int) int {
	slices.SortFunc(tasks, func(a, b []int) int {
		return (b[1] - b[0]) - (a[1] - a[0])
	})

	energy := 0
	answer := 0

	for _, task := range tasks {
		actual := task[0]
		minimum := task[1]

		if energy < minimum {
			answer += minimum - energy
			energy = minimum
		}

		energy -= actual
	}

	return answer
}
