package main

func numJewelsInStones(jewels string, stones string) int {
	a := map[rune]bool{}

	for _, j := range jewels {
		a[j] = true
	}

	result := 0

	for _, s := range stones {
		_, ok := a[s]
		if ok {
			result++
		}
	}

	return result
}
