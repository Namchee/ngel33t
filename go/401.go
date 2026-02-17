package main

import "fmt"

func generate(idx int, count int, curr int, combination *[]string) {
	if count == 0 {
		hour := 0
		minutes := 0

		for val := range 4 {
			if curr&(1<<(6+val)) > 0 {
				hour |= (1 << val)
			}
		}

		for val := range 6 {
			if curr&(1<<val) > 0 {
				minutes |= (1 << val)
			}
		}

		if hour <= 11 && minutes <= 59 {
			*combination = append(*combination, fmt.Sprintf("%d:%02d", hour, minutes))
		}

		return
	}

	if idx > 9 {
		return
	}

	generate(idx+1, count-1, curr|(1<<idx), combination)
	generate(idx+1, count, curr, combination)
}

func readBinaryWatch(turnedOn int) []string {
	possible := []string{}

	if turnedOn > 10 {
		return possible
	}

	generate(0, turnedOn, 0, &possible)

	return possible
}
