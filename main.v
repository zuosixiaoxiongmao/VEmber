module main

import ember.core {Ecs, ServicerComponent, ServicerSystem, SystemMessageData}

import ember.app {Transform, UnitData, InputData, MoveSystem, InputSystem}

pub fn f(x int, y int) int {
	return 2 * x - y
}

pub fn f2(cb fn (x int, y int) int) int {
	a := 2
	b := 3
	return cb(a, b)+1
}

struct SystemMessage{

}


fn main() {
	
}