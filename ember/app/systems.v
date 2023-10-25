module app

import core {System}

pub struct MoveSystem {
	System
}

pub fn (mut self MoveSystem)init() {
	//query<>()
	println('1111111111111')
	for entity in self.selector().and<Transform>().query() {
		println('22222222')
	}
	
}

pub fn (mut self MoveSystem)update() {
}



pub struct InputSystem {
	System
}

pub fn (mut self InputSystem)init() {
	for entity in self.selector().and<InputData>().and<UnitData>().query() {
	}
}

pub fn (mut self InputSystem)update() {
	for entity in self.selector().and<InputData>().and<UnitData>().query() {
		println('InputSystem update')
		//com := self.ecs.get_component<ServicerComponent>(entity)
	}

}

