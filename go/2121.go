package main

func getDistances(arr []int) []int64 {
	n := len(arr)
	result := make([]int64, n)
	mp := map[int][]int{}

	for idx, num := range arr {
		mp[num] = append(mp[num], idx)
	}

	for _, v := range mp {
		prefix := 0
		for _, n := range v {
			prefix += n
		}

		lsum := 0
		m := len(v)

		for i := 0; i < m; i++ {
			rsum := prefix - lsum - v[i]

			left := v[i]*i - lsum
			right := rsum - (v[i] * (m - i - 1))

			result[v[i]] = int64(left + right)
			lsum += v[i]
		}
	}

	return result
}
