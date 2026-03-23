package main

func restoreString(s string, indices []int) string {
	temp := make([]byte, len(s))

	for i := 0; i < len(s); i++ {
		temp[indices[i]] = s[i]
	}

	return string(temp)
}
