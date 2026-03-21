package main

func majorityFrequencyGroup(s string) string {
	freq := map[rune]int{}
	for _, ch := range s {
		freq[ch]++
	}

	best := map[int][]rune{}
	maxGroupSize := 0
	bestFreq := 0

	for char, count := range freq {
		best[count] = append(best[count], char)
		currentGroupSize := len(best[count])

		if currentGroupSize > maxGroupSize || (currentGroupSize == maxGroupSize && count > bestFreq) {
			maxGroupSize = currentGroupSize
			bestFreq = count
		}
	}

	return string(best[bestFreq])
}
