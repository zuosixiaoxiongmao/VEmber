module main

import ember.core {Ecs}
import ember.parts {ServicerComponent, ServicerSystem, SystemMessageData}

import ember.app {Transform, UnitData, InputData, MoveSystem, InputSystem}
import ember.utilities {ConfigParse}


fn test_ecs() {
	mut ecs := Ecs.new()
	mut root := ecs.create_entity()
	ecs.add_component<ServicerComponent>(root)
	go ecs.update()
}

fn test_config_parse() {
	con_parse := ConfigParse.new()
}