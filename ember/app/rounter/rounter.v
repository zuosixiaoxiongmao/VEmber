module rounter

import vweb
import core {Entity, System, ServicerComponent}
import parts {ConfigComponent}

pub struct HttpComponent {
	vweb.Context
}

fn (mut app HttpComponent) hello() vweb.Result {
	return app.text('Hello')
}

['/foo']
fn (mut app HttpComponent) world() vweb.Result {
	return app.text('World')
}

[post]
fn (mut app HttpComponent) say() vweb.Result {
	return app.text('World')
}

['/hello/:user']
fn (mut app HttpComponent) hello_user(user string) vweb.Result {
	return app.text('Hello $user')
}

pub struct HttpSystem {
	System
}

pub fn (mut self HttpSystem)init() {
	mut config_entity := 0
	for entity in self.selector().and<ConfigComponent>().query() {
		config_entity = entity
	}

	for entity in self.selector().and<HttpComponent>().query() {
		http_com := self.ecs.get_component<HttpComponent>(entity)
		config_com := self.ecs.get_component<ConfigComponent>(entity)
		vweb.run(http_com, config_com.rounter_port)
	}
	
}

pub fn (mut self HttpSystem)update() {
	for entity in self.selector().and<HttpComponent>().query() {

	}
}


