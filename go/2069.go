package main

type Robot struct {
	width  int
	height int

	hasMoved bool
	pos      int
}

func Constructor(width int, height int) Robot {
	return Robot{
		width:  width,
		height: height,

		hasMoved: false,
		pos:      0,
	}
}

func (this *Robot) Step(num int) {
	this.hasMoved = true
	perimeter := 2*(this.width-1) + 2*(this.height-1)
	this.pos = (this.pos + num) % perimeter
}

func (this *Robot) GetPos() []int {
	pos := this.pos

	if pos < this.width {
		return []int{pos, 0}
	} else if pos < this.width+this.height-1 {
		return []int{this.width - 1, pos - (this.width - 1)}
	} else if pos < 2*this.width+this.height-2 {
		return []int{this.width - 1 - (pos - (this.width + this.height - 2)), this.height - 1}
	}

	return []int{0, this.height - 1 - (pos - (2*this.width + this.height - 3))}
}

func (this *Robot) GetDir() string {
	if this.hasMoved && this.pos == 0 {
		return "South"
	}

	pos := this.pos
	if pos >= 1 && pos < this.width {
		return "East"
	} else if pos >= this.width && pos < this.width+this.height-1 {
		return "North"
	} else if pos >= this.width+this.height-1 && pos < 2*this.width+this.height-2 {
		return "West"
	}

	if !this.hasMoved {
		return "East"
	}
	return "South"
}

/**
 * Your Robot object will be instantiated and called as such:
 * obj := Constructor(width, height);
 * obj.Step(num);
 * param_2 := obj.GetPos();
 * param_3 := obj.GetDir();
 */
