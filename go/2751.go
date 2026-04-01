package main

import "slices"

type Robot struct {
	position  int
	health    int
	direction byte
	idx       int
}

func survivedRobotsHealths(positions []int, healths []int, directions string) []int {
	robots := []Robot{}

	for i := 0; i < len(positions); i++ {
		robots = append(robots, Robot{
			position:  positions[i],
			health:    healths[i],
			direction: directions[i],
			idx:       i, // for sorting later
		})
	}

	slices.SortFunc(robots, func(a Robot, b Robot) int {
		return a.position - b.position
	})

	stack := []Robot{}

	for i := 0; i < len(positions); i++ {
		curr := robots[i]

		if len(stack) == 0 {
			stack = append(stack, curr)
			continue
		}

		flag := false

		for len(stack) > 0 {
			top := stack[len(stack)-1]

			if top.direction == curr.direction || (top.direction == 'L' && curr.direction == 'R') {
				break
			}

			// remove top only, but don't add curr
			if top.health == curr.health {
				flag = true
				stack = stack[0 : len(stack)-1]
				break
			}

			// just substract top
			if top.health > curr.health {
				flag = true
				stack[len(stack)-1].health--
				break
			}

			stack = stack[0 : len(stack)-1]
			curr.health--
		}

		if !flag {
			stack = append(stack, curr)
		}
	}

	slices.SortFunc(stack, func(a, b Robot) int {
		return a.idx - b.idx
	})

	result := []int{}

	for _, robot := range stack {
		result = append(result, robot.health)
	}

	return result
}
