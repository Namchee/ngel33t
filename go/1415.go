package main

var SET = []rune{'a', 'b', 'c'}

func generateHappy(idx int, container []rune, result *[]string) {
	if idx >= len(container) {
		*result = append(*result, string(container))
		return
	}

	for _, ch := range SET {
		if idx == 0 || container[idx-1] != ch {
			container[idx] = ch
			generateHappy(idx+1, container, result)
		}
	}

}

func getHappyString(n int, k int) string {
	container := make([]rune, n)
	result := []string{}

	generateHappy(0, container, &result)

	if k > len(result) {
		return ""
	}

	return result[k-1]
}
