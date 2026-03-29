package main

func removeDuplicateLetters(s string) string {
	occ := map[rune]int{}
	for idx, ch := range s {
		occ[ch] = idx
	}

	stack := []rune{}
	seen := map[rune]bool{}

	for idx, ch := range s {
		if !seen[ch] {
			for len(stack) > 0 && ch < stack[len(stack)-1] && occ[stack[len(stack)-1]] > idx {
				top := stack[len(stack)-1]
				stack = stack[:len(stack)-1]
				seen[top] = false
			}

			stack = append(stack, ch)
			seen[ch] = true
		}
	}

	return string(stack)
}
