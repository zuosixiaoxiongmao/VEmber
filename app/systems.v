module app

import core {System, ServicerComponent}

pub struct MoveSystem {
	System
}

pub fn (self MoveSystem)init() {
	//query<>()
	println('1111111111111')
	for entity in self.selector().and<Transform>().query() {
		println('22222222')
	}
	
}

pub fn (self MoveSystem)update() {
}



pub struct InputSystem {
	System
}

pub fn (self InputSystem)init() {
	for entity in self.selector().and<InputData>().and<UnitData>().query() {
	}
}

pub fn (self InputSystem)update() {
	for entity in self.selector().and<InputData>().and<UnitData>().query() {
		println('InputSystem update')
		//com := self.ecs.get_component<ServicerComponent>(entity)
	}
	for entity in self.selector().and<ServicerComponent>().query() {
		com := self.ecs.get_component<ServicerComponent>(entity)
		self.ecs.push_event()
	}
}

