module core

pub struct BitSet {
	mut:
		bit_array [16]u8

}

fn (mut self BitSet) reset() {
	for mut v in self.bit_array {
		v = 0
	}
}

fn (mut self BitSet) set(v u64) {
	self.bit_array[v/8] &=  (1 << (v % 8))
}

fn (lhs BitSet) == (rhs BitSet) bool {
	if lhs.str() == rhs.str(){
		return true
	}
	return false
}