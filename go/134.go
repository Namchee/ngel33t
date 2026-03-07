package main

func canCompleteCircuit(gas []int, cost []int) int {
	for i := 0; i < len(gas); i++ {
		start := i
		tank := 0

		for true {
			tank += gas[start]
			if tank < cost[start] {
				break
			}

			tank -= cost[start]
			start = (start + 1) % len(gas)

			if start == i {
				return i
			}
		}
	}

	return -1
}
