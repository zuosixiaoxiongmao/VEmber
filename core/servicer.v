module core

struct Message {

}

pub struct ServicerComponent {
	pub mut:
		messages []Message
}

pub fn (self ServicerComponent)send(entity Entity) {

}

pub fn (self ServicerComponent) call(entity Entity) {
	
}

pub struct ServicerSystem {
	System
}


pub fn (self ServicerSystem)init() {
	//self.ecs.add_event_listener()
}

pub fn (self ServicerSystem)update() {
	for entity in self.selector().and<ServicerComponent>().query() {
		println('ServicerSystem update')
	}
}

pub fn (self ServicerSystem)push_message(message Message) {
	for entity in self.selector().and<ServicerComponent>().query() {
		com := self.ecs.get_component<ServicerComponent>(entity)
		com.messages << Message{}
	}
}