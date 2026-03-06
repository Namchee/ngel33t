package main

func checkZeroOnes(s string) bool {
	if len(s) == 0 {
		return false
	}

	last := s[0]
	curr := 1

	bestZero := 0
	bestOne := 0

	for i := 1; i < len(s); i++ {
		if s[i] == last {
			curr++
		} else {
			if last == '0' {
				bestZero = max(bestZero, curr)
			} else {
				bestOne = max(bestOne, curr)
			}

			last = s[i]
			curr = 1
		}
	}

	if last == '0' {
		bestZero = max(bestZero, curr)
	} else {
		bestOne = max(bestOne, curr)
	}

	return bestOne > bestZero
}
