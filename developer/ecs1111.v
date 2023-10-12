type Entity = u64

pub struct EntityManager {
}

pub struct ComponentManager {
}

pub struct System {
	pub mut:
		ecs &Ecs
}

pub struct MSystem {
	System
}

pub struct SystemManager {
}

fn (mut self SystemManager) add_system<T>() &T{
	mut t := T{}
	return &t
}

[heap]
pub struct Ecs {
	mut:
		entity_manager EntityManager
		component_manager ComponentManager
		system_manager SystemManager
}

pub fn Ecs.new() &Ecs {
	mut ecs := &Ecs{}
	return ecs
}

pub fn (mut self Ecs) create_entity() Entity {
	return 0
}

pub fn (mut self Ecs) add_component<T>(entity Entity){
}

pub fn (mut self Ecs) add_system<T>(){
	mut system := self.system_manager.add_system<T>()
	system.ecs = &self
}



pub struct Transform {
	mut:
	position []f32
}

pub struct UnitData {
	mut:
		proto_id u64
}

pub struct MoveSystem {
	System
}



pub struct ServicerComponent {
}

pub struct ServicerSystem {
	MSystem
}


mut ecs := Ecs.new()
entity := ecs.create_entity()
ecs.add_component<Transform>(entity)
ecs.add_component<ServicerComponent>(entity)
ecs.add_system<MoveSystem>()
ecs.add_system<ServicerSystem>()
//tmp.c:12788: error: field not found: MSystem
//C error. This should never happen.