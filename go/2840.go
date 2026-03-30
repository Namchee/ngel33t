package main

func checkStrings(s1 string, s2 string) bool {
	even := map[rune]int{}
	odd := map[rune]int{}

	for idx, ch := range s1 {
		if idx%2 == 0 {
			even[ch]++
		} else {
			odd[ch]++
		}
	}

	for idx, ch := range s2 {
		if idx%2 == 0 {
			ct, ok := even[ch]
			if !ok || ct <= 0 {
				return false
			}

			if ct == 1 {
				delete(even, ch)
			} else {
				even[ch]--
			}

		} else {
			ct, ok := odd[ch]
			if !ok || ct <= 0 {
				return false
			}

			if ct == 1 {
				delete(odd, ch)
			} else {
				odd[ch]--
			}

		}
	}

	return len(even) == 0 && len(odd) == 0
}
