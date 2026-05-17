package main

func canReach(arr []int, start int) bool {
	visited := make([]bool, len(arr))
	visited[start] = true

	q := []int{}
	q = append(q, start)

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		if arr[curr] == 0 {
			return true
		}

		left := curr - arr[curr]
		if left >= 0 && !visited[left] {
			visited[left] = true
			q = append(q, left)
		}

		right := curr + arr[curr]
		if right < len(arr) && !visited[right] {
			visited[right] = true
			q = append(q, right)
		}
	}

	return false
}
