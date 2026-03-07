package main

func canCompleteCircuit(gas []int, cost []int) int {
	rem := 0
	tank := 0

	start := 0

	for i := 0; i < len(gas); i++ {
		rem += gas[i] - cost[i]
		tank += gas[i] - cost[i]

		if tank < 0 {
			tank = 0
			start = i + 1
		}
	}

	if rem < 0 {
		return -1
	}

	return start
}
