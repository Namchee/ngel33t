package main

func maximu(a, b int) int {
	if a > b {
		return a
	}

	return b
}

func wordSubsets(words1 []string, words2 []string) []string {
	freqA := make([][]int, len(words1))
	uniFreq := make([]int, 26)

	for i := 0; i < len(words1); i++ {
		freqA[i] = make([]int, 26)
	}

	for i := 0; i < len(words1); i++ {
		for j := 0; j < len(words1[i]); j++ {
			freqA[i][words1[i][j]-'a']++
		}
	}

	for i := 0; i < len(words2); i++ {
		f := make([]int, 26)

		for j := 0; j < len(words2[i]); j++ {
			f[words2[i][j]-'a']++
		}

		for j := 0; j < 26; j++ {
			uniFreq[j] = maximu(uniFreq[j], f[j])
		}
	}

	result := []string{}

	for i := 0; i < len(words1); i++ {
		flag := true

		for k := 0; k < 26 && flag; k++ {
			if freqA[i][k] < uniFreq[k] {
				flag = false
			}
		}

		if flag {
			result = append(result, words1[i])
		}
	}

	return result
}
