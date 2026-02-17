package main

func isAnagram(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	// rune is used to handle unicode
	mp := map[rune]int{}

	for _, val := range s {
		_, ok := mp[val]
		if ok {
			mp[val] += 1
		} else {
			mp[val] = 1
		}
	}

	for _, chr := range t {
		val, ok := mp[chr]
		if ok {
			if val == 1 {
				delete(mp, chr)
			} else {
				mp[chr] -= 1
			}

			continue
		}

		return false
	}

	return len(mp) == 0
}
