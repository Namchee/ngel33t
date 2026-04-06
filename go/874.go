package main

type Coord struct{ x, y int }

func robotSim(commands []int, obstacles [][]int) int {
	x := 0
	y := 0

	dir := 0
	walker := [][]int{
		[]int{0, 1},  // north
		[]int{1, 0},  // east
		[]int{0, -1}, // south
		[]int{-1, 0}, // west
	}

	obsMap := make(map[Coord]bool)
	for _, b := range obstacles {
		obsMap[Coord{b[0], b[1]}] = true
	}

	best := 0

	for _, cmd := range commands {
		if cmd == -1 {
			dir = (dir + 1) % 4
		} else if cmd == -2 {
			temp := dir - 1

			if temp == -1 {
				temp = 3
			}

			dir = temp
		} else {
			for i := 0; i < cmd; i++ {
				nextX := x + walker[dir][0]
				nextY := y + walker[dir][1]

				if obsMap[Coord{nextX, nextY}] {
					break
				}
				x, y = nextX, nextY
				best = max(best, x*x+y*y)
			}
		}
	}

	return best
}
