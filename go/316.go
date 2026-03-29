package main

func generateUSLS(pos map[rune][]int, last int, members map[rune]bool, curr []rune) string {
	if len(members) == 0 {
		return string(curr)
	}

	for i := 0; i < 26; i++ {
		ch := rune(i + 'a')
		_, ok := members[ch]

		// not used yet
		if ok {
			for _, idx := range pos[ch] {
				if idx > last {
					delete(members, ch)
					newCurr := append(curr, ch)
					attempt := generateUSLS(pos, idx, members, newCurr)

					if len(attempt) > 0 {
						return attempt
					}

					members[ch] = true
				}
			}
		}

	}

	// shouldn't be possible
	return ""
}

func removeDuplicateLetters(s string) string {
	mp := map[rune][]int{}
	members := map[rune]bool{}

	for i := 0; i < 26; i++ {
		mp[rune(i+'a')] = []int{}
	}

	for idx, ch := range s {
		mp[ch] = append(mp[ch], idx)
		members[ch] = true
	}

	return generateUSLS(mp, -1, members, []rune{})
}
