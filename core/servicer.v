module core

pub struct SystemMessageData {

}

pub struct ServicerComponent {
	pub mut:
		messages []SystemMessageData
}



pub struct ServicerSystem {
	System
}

pub fn push_message(sys &ServicerSystem, e &SystemMessageData, sender voidptr){
	for entity in sys.selector().and<ServicerComponent>().query() {
		mut com := sys.ecs.get_component<ServicerComponent>(entity)
		com.messages << e
	}
}


pub fn (mut self ServicerSystem)init() {
	self.ecs.event_bus.subscriber.subscribe_method(1,push_message, &self)
}

pub fn (mut self ServicerSystem)update() {
	for entity in self.selector().and<ServicerComponent>().query() {
		mut com := self.ecs.get_component<ServicerComponent>(entity)
	}
}

