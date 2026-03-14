package main

func shiftingLetters(s string, shifts []int) string {
	letters := "abcdefghijklmnopqrstuvwxyz"
	shift := 0

	result := []byte{}
	for _, ch := range s {
		result = append(result, byte(ch))
	}

	for i := len(s) - 1; i >= 0; i-- {
		old := s[i] - 'a'
		shift = (shift + shifts[i]) % 26
		new := (old + byte(shift)) % 26

		result[i] = letters[new]
	}

	return string(result)
}
