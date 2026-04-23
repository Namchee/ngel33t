package main

func distance(nums []int) []int64 {
	result := make([]int64, len(nums))
	mp := map[int][]int{}

	for idx, num := range nums {
		mp[num] = append(mp[num], idx)
	}

	for _, v := range mp {
		prefix := 0

		for _, num := range v {
			prefix += num
		}

		lsum := 0

		for i := 0; i < len(v); i++ {
			left := v[i]*i - lsum
			right := (prefix - lsum - v[i]) - v[i]*(len(v)-i-1)

			result[v[i]] = int64(left + right)
			lsum += v[i]
		}
	}

	return result
}
