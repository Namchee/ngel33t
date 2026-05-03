package main

func findValidPair(s string) string {
	cnt := make(map[rune]int)
	for _, c := range s {
		cnt[c]++
	}

	for i := 1; i < len(s); i++ {
		if s[i] != s[i-1] && cnt[rune(s[i])] == int(s[i]-'0') && cnt[rune(s[i-1])] == int(s[i-1]-'0') {
			return s[i-1 : i+1]
		}
	}

	return ""
}
