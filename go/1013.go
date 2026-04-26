package main

func canThreePartsEqualSum(arr []int) bool {
	sum := 0
	for _, v := range arr {
		sum += v
	}

	if sum%3 != 0 {
		return false
	}

	target := sum / 3
	curr := 0
	count := 0

	for i := 0; i < len(arr)-1; i++ {
		curr += arr[i]
		if curr == target {
			count++
			curr = 0

			if count == 2 {
				return true
			}
		}
	}

	return false
}
