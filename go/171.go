package main

func titleToNumber(columnTitle string) int {
	result := 0

	for idx, ch := range columnTitle {
		mult := ch - 'A' + 1
		base := 1
		po := len(columnTitle) - 1 - idx
		for ct := 0; ct < po; ct++ {
			base *= 26
		}

		result += base * int(mult)
	}

	return result
}
