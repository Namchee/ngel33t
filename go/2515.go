package main

func closestTarget(words []string, target string, startIndex int) int {
	n := len(words)
	best := n
	found := false

	for i, word := range words {
		if word == target {
			found = true

			distForward := (i - startIndex + n) % n
			distBackward := (startIndex - i + n) % n

			best = min(best, distForward, distBackward)
		}
	}

	if !found {
		return -1
	}
	return best
}
