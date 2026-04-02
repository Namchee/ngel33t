package main

import (
	"math"
)

func maximumAmount(coins [][]int) int {
	table := make([][][]int, len(coins))
	for i := 0; i < len(coins); i++ {
		table[i] = make([][]int, len(coins[i]))

		for j := 0; j < len(coins[i]); j++ {
			table[i][j] = make([]int, 3)
		}
	}

	for i := 0; i < len(coins); i++ {
		for j := 0; j < len(coins[i]); j++ {
			for k := 0; k < 3; k++ {
				// yep, got 3 WA because of bad base case, very nice
				if i == 0 && j == 0 {
					table[i][j][0] = coins[i][j]
					if k > 0 && coins[i][j] < 0 {
						table[i][j][k] = 0
					} else if k > 0 {
						table[i][j][k] = coins[i][j]
					}
					continue
				}

				init := math.MinInt

				if i > 0 {
					init = max(init, table[i-1][j][k]+coins[i][j])
				}

				if j > 0 {
					init = max(init, table[i][j-1][k]+coins[i][j])
				}

				if coins[i][j] < 0 && k > 0 {
					np := math.MinInt

					if i > 0 {
						np = max(np, table[i-1][j][k-1])
					}
					if j > 0 {
						np = max(np, table[i][j-1][k-1])
					}

					init = max(init, np)
				}

				table[i][j][k] = init
			}
		}
	}

	return max(table[len(table)-1][len(table[0])-1][0],
		max(table[len(table)-1][len(table[0])-1][1], table[len(table)-1][len(table[0])-1][2]))
}
