package main

const FancyMod = 1000000007

func pow(base, exp int) int {
	res := 1
	base %= FancyMod
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % FancyMod
		}

		base = (base * base) % FancyMod
		exp /= 2
	}
	return res
}

type Fancy struct {
	sequence []int
	mult     int
	inc      int
}

func Constructor() Fancy {
	return Fancy{
		sequence: []int{},
		mult:     1,
		inc:      0,
	}
}

func (this *Fancy) Append(val int) {
	// (val - add) * inv(mul)
	temp := (val - this.inc + FancyMod) % FancyMod
	this.sequence = append(this.sequence, (temp*pow(this.mult, FancyMod-2))%FancyMod)
}

func (this *Fancy) AddAll(inc int) {
	this.inc = (this.inc + inc) % FancyMod
}

func (this *Fancy) MultAll(m int) {
	this.mult = (this.mult * m) % FancyMod
	this.inc = (this.inc * m) % FancyMod // need to distribute the multiplier
}

func (this *Fancy) GetIndex(idx int) int {
	if idx >= len(this.sequence) {
		return -1
	}

	res := (this.sequence[idx] * this.mult) % FancyMod
	res = (res + this.inc) % FancyMod

	return res
}
