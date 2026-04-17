package main

func kItemsWithMaximumSum(numOnes int, numZeros int, numNegOnes int, k int) int {
	sum := 0

	for k > 0 && numOnes > 0 {
		sum++
		k--
		numOnes--
	}

	for k > 0 && numZeros > 0 {
		k--
		numZeros--
	}

	for k > 0 && numNegOnes > 0 {
		k--
		sum--
		numNegOnes--
	}

	return sum
}
