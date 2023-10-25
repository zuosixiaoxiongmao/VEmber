module main

import ember.core {Ecs}
import ember.parts {ServicerComponent, ServicerSystem, SystemMessageData}

import ember.app {Transform, UnitData, InputData, MoveSystem, InputSystem}


fn test_ecs() {
	mut ecs := Ecs.new()
	entity := ecs.create_entity()
	ecs.add_component<Transform>(entity)
	ecs.add_component<UnitData>(entity)
	ecs.add_component<InputData>(entity)
	ecs.add_component<ServicerComponent>(entity)
	ecs.add_system<MoveSystem>()
	ecs.add_system<InputSystem>()
	ecs.add_system<ServicerSystem>()
	ecs.send<ServicerComponent>(entity, &SystemMessageData{})
	ecs.update()
}