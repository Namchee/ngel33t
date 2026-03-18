package main

func lemonadeChange(bills []int) bool {
	fives := 0
	tens := 0
	twenties := 0

	for _, bill := range bills {
		switch bill {
		case 5:
			fives++
		case 10:
			tens++
		case 20:
			twenties++
		}

		ret := bill - 5

		for ret >= 20 && twenties > 0 {
			twenties--
			ret -= 20
		}

		for ret >= 10 && tens > 0 {
			tens--
			ret -= 10
		}

		for ret >= 5 && fives > 0 {
			fives--
			ret -= 5
		}

		if ret > 0 {
			return false
		}
	}

	return true
}
