package main

func asteroidCollision(asteroids []int) []int {
	stack := []int{}

	for _, asteroid := range asteroids {
		if len(stack) == 0 {
			stack = append(stack, asteroid)
			continue
		}

		isDead := false

		for len(stack) > 0 {
			curr := asteroid
			top := stack[len(stack)-1]
			if (top < 0 && asteroid < 0) || (top > 0 && asteroid > 0) || (top < 0 && curr > 0) {
				break
			}

			if top < 0 {
				top *= -1
			}

			if curr < 0 {
				curr *= -1
			}

			if curr == top {
				stack = stack[0 : len(stack)-1]
				isDead = true
				break
			}

			if curr < top {
				isDead = true
				break
			}

			stack = stack[0 : len(stack)-1]
		}

		if !isDead {
			stack = append(stack, asteroid)
		}
	}

	return stack
}
