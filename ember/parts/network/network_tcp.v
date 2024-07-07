module network

import core {Ecs, System, Entity}
import utilities
import io
import net

[heap]
pub struct NetworkTcpReceiveComponent {
	//pub mut:
		//socket net.TcpConn
}

pub struct NetworkTcpReceiveSystem {
	System
}

fn (mut self NetworkTcpReceiveSystem) handle_client(entity Entity, mut sys &NetworkTcpReceiveSystem, mut ntrc &NetworkClientReceiveComponent) {
	mut socket := &ntrc.socket
	defer {
		socket.close() or { panic(err) }
		sys.ecs.remove_component<NetworkTcpReceiveComponent>(entity)
	}
	client_addr := socket.peer_addr() or { return }
	eprintln('> new client: ${client_addr}')
	mut reader := io.new_buffered_reader(reader: socket)
	defer {
		unsafe {
			reader.free()
		}
	}
	for {
		//reader.read(received) or { panic(err) }
		//buff_com := sys.ecs.get_component<NetworkReceiveBuffComponent>(entity)
		//buff_com.receive_buff.append(received)
	}
}


pub fn (mut self NetworkTcpReceiveSystem) init() {
	for entity in self.ecs.selector().and<NetworkTcpReceiveComponent>().query() {
		mut ntrc := self.ecs.get_component<NetworkTcpReceiveComponent>(entity)
		self.ecs.add_component<NetworkReceiveBuffComponent>(entity)
		//spawn handle_client(entity, self, ntrc)
	}
}

pub fn (mut self NetworkTcpReceiveSystem) update() {
	for entity in self.ecs.selector().and<NetworkReceiveBuffComponent>().query() {
		ntrc := self.ecs.get_component<NetworkReceiveBuffComponent>(entity)

	}
}


pub struct NetworkTcpServerComponent {
}



pub struct NetworkServerSystemTcp {
	
	System
}


pub fn init_tcp(mut self &NetworkServerSystemTcp, port string){
	mut server := net.listen_tcp(.ip6, ':' + port) or { panic(err) }
	laddr := server.addr() or { panic(err) }
	eprintln('Listen on ${laddr} ...')
	for {
		mut socket := server.accept() or { panic(err) }
		mut entity := self.ecs.create_entity()
		com := self.ecs.add_component<NetworkTcpReceiveComponent>(entity)
		//com.socket = socket
		//self.ecs.add_system<NetworkTcpReceiveSystem>(entity)
		//		handle_client(socket )
	}
}


pub fn (mut self NetworkServerSystemTcp) init() {
	for entity in self.ecs.selector().and<NetworkTcpServerComponent>().query() {
		ntsc := self.ecs.get_component<NetworkTcpServerComponent>(entity)
		//spawn init_tcp(self)
	}
}


pub fn (mut self NetworkServerSystemTcp) update() {
	for entity in self.ecs.selector().and<NetworkTcpServerComponent>().query() {
	}
}

