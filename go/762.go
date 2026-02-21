package main

func countPrimeSetBits(left int, right int) int {
	fakeSet := map[int]interface{}{
		2:  "",
		3:  "",
		5:  "",
		7:  "",
		11: "",
		13: "",
		17: "",
		19: "",
	}

	result := 0

	for ct := left; ct <= right; ct++ {
		temp := ct
		count := 0

		for temp > 0 {
			count += temp & 1
			temp >>= 1
		}

		_, ok := fakeSet[count]
		if ok {
			result++
		}
	}

	return result
}
