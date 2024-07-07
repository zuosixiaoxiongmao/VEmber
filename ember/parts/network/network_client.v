module network
import core {Ecs, System, Entity}
import net

pub struct NetworkClientObject {
	pub mut:
		receive_buff []u8 = []
		send_buff []u8 = []
		url string
		//socket net.TcpConn
}

[heap]
pub struct NetworkClientComponent {
	pub mut :
	url string
}


pub fn (self NetworkClientComponent) send_message() {
	
}

pub struct NetworkClientSystem {
	System
}


pub fn (mut self NetworkClientSystem) init() {
	for entity in self.ecs.selector().and<NetworkClientComponent>().query() {
		ncc := self.ecs.get_component<NetworkClientComponent>(entity)
		mut tcp_connector := TcpConnector{}
		//ncc.socket = net.connecting(ncc.url)!
	}
}

pub fn (mut self NetworkClientSystem) update() {
	for entity in self.ecs.selector().and<NetworkUdpServerComponent>().query() {
		ncc := self.ecs.get_component<NetworkClientComponent>(entity)
		//received := reader.read_any() or {continue}
		//ncc.receive_buff.append(received)
		//msgs := self.ecs.get_message(entity)
		//for msg in msgs {
		//	net.send(ncc.socket, msg)	
		//}
	}
}


pub struct NetworkClientReceiveComponent {
	System
	pub mut:
		socket net.TcpConn
}