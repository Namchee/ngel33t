package main

func twoEdit(a, b string) bool {
	diff := 0

	for i := 0; i < len(a); i++ {
		if a[i] != b[i] {
			diff++
		}
	}

	return diff <= 2
}

func twoEditWords(queries []string, dictionary []string) []string {
	result := []string{}

	for _, q := range queries {
		for _, dict := range dictionary {
			if len(q) == len(dict) && twoEdit(q, dict) {
				result = append(result, q)
				break
			}
		}
	}

	return result
}
