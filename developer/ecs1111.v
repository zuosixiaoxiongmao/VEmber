[deprecated]

module ecs

pub interface IComponent {
}

pub interface IComponentSystem {
	oncreate()
	onupdate()
	ondestory()
}

pub interface IEntity {
	add_component(com IComponent)
	add_child()
}

pub struct Entity {
	id i64
	
mut:
	components  map[i64]IComponent={}
}

fn (mut self Entity) add_component<T>() {
	self.components[1] = T{}
}

pub struct Component {
}

pub struct ComponentSystem {
}

fn (self ComponentSystem) oncreate(){
	print('ComponentSystem oncreate')
}

fn (self ComponentSystem) onupdate(){
}

fn (self ComponentSystem) ondestory(){
	print('ComponentSystem ondestory')
}

pub struct World {
	mut:
		component_system []IComponentSystem
		entities []Entity
}

fn (mut self World) add_system<T>(){
	self.component_system << T{}
}

fn (self World) add_entity(){
	
}

fn (self World) update_component_system(){
	for sys in self.component_system {
		sys.onupdate()
	}
}


pub struct MovementComponent {
	Component
	mut:
		x f32
		y f32
		z f32
}


pub struct MovementSystem {
	ComponentSystem
}

fn (self MovementSystem) oncreate(){
	print('MovementSystem oncreate')
}

fn (self MovementSystem) onupdate(){
}

fn (self MovementSystem) ondestory(){
	print('MovementSystem ondestory')
}


world := World{}

world.update_component_system()

mover := MovementSystem{}
mover.ComponentSystem.ondestory()
mut component_system := []ComponentSystem{}
component_system <<  mover.ComponentSystem
