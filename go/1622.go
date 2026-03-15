package main

const FancyMod = 1000000007

type FancyValue struct {
	val int
	idx int // operation index
}

type FancyOperation struct {
	op  byte
	val int
}

type Fancy struct {
	sequence   []FancyValue
	operations []FancyOperation
}

func Constructor() Fancy {
	return Fancy{}
}

func (this *Fancy) Append(val int) {
	this.sequence = append(this.sequence, FancyValue{val: val, idx: len(this.operations)})
}

func (this *Fancy) AddAll(inc int) {
	this.operations = append(this.operations, FancyOperation{op: '+', val: inc})
}

func (this *Fancy) MultAll(m int) {
	this.operations = append(this.operations, FancyOperation{op: '*', val: m})
}

func (this *Fancy) GetIndex(idx int) int {
	if idx >= len(this.sequence) {
		return -1
	}

	for i := this.sequence[idx].idx; i < len(this.operations); i++ {
		if this.operations[i].op == '*' {
			this.sequence[idx].val = (this.sequence[idx].val * this.operations[i].val) % FancyMod
		} else {
			this.sequence[idx].val = (this.sequence[idx].val + this.operations[i].val) % FancyMod
		}
	}

	this.sequence[idx].idx = len(this.operations)

	return this.sequence[idx].val
}
