package main

func minPartitions(n string) int {
	result := 0

	for _, ch := range n {
		num := int(ch) - '0'
		if num > result {
			result = num
		}
	}

	return result
}
