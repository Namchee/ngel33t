package main

import "fmt"

func generateLexical(curr int, result *[]int, lim int) {
	if curr > lim {
		return
	}

	fmt.Println(curr)

	if curr != 0 && len(*result) < lim {
		*result = append(*result, curr)
	}

	for i := 0; i <= 9; i++ {
		if curr == 0 && i == 0 {
			continue
		}

		generateLexical(curr*10+i, result, lim)
	}
}

func lexicalOrder(n int) []int {
	result := []int{}

	generateLexical(0, result, n)

	return result
}
