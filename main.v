module main

import core {Ecs, ServicerComponent, ServicerSystem, SystemMessageData}

import app {Transform, UnitData, InputData, MoveSystem, InputSystem}

pub fn f(x int, y int) int {
	return 2 * x - y
}

pub fn f2(cb fn (x int, y int) int) int {
	a := 2
	b := 3
	return cb(a, b)+1
}


fn main() {
	mut ecs := Ecs.new()
	entity := ecs.create_entity()
	ecs.add_component<Transform>(entity)
	ecs.add_component<UnitData>(entity)
	ecs.add_component<InputData>(entity)
	ecs.add_component<ServicerComponent>(entity)
	ecs.add_system<MoveSystem>()
	ecs.add_system<InputSystem>()
	ecs.add_system<ServicerSystem>()
	//ecs.send<ServicerComponent, SystemMessage>(entity, SystemMessage{})
	ecs.update()

}