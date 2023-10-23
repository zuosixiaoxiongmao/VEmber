module rounter

import core {System, ServicerComponent}

struct HttpComponent {
	
}

pub struct HttpSystem {
	System
}

pub fn (mut self HttpSystem)init() {
	
}

pub fn (mut self HttpSystem)update() {
	for entity in self.selector().and<HttpComponent>().query() {
	}
}


