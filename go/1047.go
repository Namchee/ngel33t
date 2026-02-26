package main

func removeDuplicates(s string) string {
	stack := []rune{}

	for _, ch := range s {
		if len(stack) == 0 {
			stack = append(stack, ch)
			continue
		}

		if stack[len(stack)-1] == ch {
			stack = stack[0 : len(stack)-1]
		} else {
			stack = append(stack, ch)
		}
	}

	return string(stack)
}
