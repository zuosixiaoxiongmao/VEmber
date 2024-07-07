module network
import time

import core {Ecs, System, Entity}
import net

pub struct NetworkUdpComponent {
	mut:
		c &net.UdpConn
		send_data []u8
}

pub struct NetworkUdpReceiveSystem {
	System
}


pub fn (mut self NetworkUdpReceiveSystem) update() {
	for entity in self.ecs.selector().and<NetworkUdpComponent>().query() {
		mut udp_com := self.ecs.get_component<NetworkUdpComponent>(entity)
		mut buf := []u8{len: 100, init: 0}
		read, addr := udp_com.c.read(mut buf) or { continue }
		self.on_recive(buf[..read], addr)
	}
}

pub fn (mut self NetworkUdpReceiveSystem) on_recive(data []u8, addr &net.Addr) {

}

pub struct NetworkUdpSendSystem {
	System
}

pub fn (mut self NetworkUdpSendSystem) update() {
	for entity in self.ecs.selector().and<NetworkUdpComponent>().query() {
		mut udp_com := self.ecs.get_component<NetworkUdpComponent>(entity)
		mut buf := []u8{len: 100, init: 0}
		read, addr := udp_com.c.read(mut buf) or { continue }
		udp_com.c.write_to(addr, buf[..read]) or {
			println('Server: connection dropped')
			return
		}
	}
}



[heap]
pub struct NetworkUdpServerComponent {
	pub mut:
		conn net.UdpConn
		clinet_map map[string]Entity={}
}


pub struct NetworkServerSystemUdp {
	System
}

fn NetworkServerSystemUdp.listen_server(mut c &net.UdpConn) {
	
	c.set_read_timeout(10 * time.second)
	c.set_write_timeout(10 * time.second)
	for { //无限循环监听,接收数据后,原样返回给客户端
		mut buf := []u8{len: 100, init: 0}
		read, addr := c.read(mut buf) or { continue }
		c.write_to(addr, buf[..read]) or {
			println('Server: connection dropped')
			return
		}
	}
}

pub fn (mut self NetworkServerSystemUdp) init() {
	for entity in self.ecs.selector().and<NetworkUdpServerComponent>().query() {
		mut ntsc := self.ecs.get_component<NetworkUdpServerComponent>(entity)
		mut conn := net.listen_udp('127.0.0.1:40003') or { panic('could not listen_udp: ${err}') }
		ntsc.conn = conn
		conn.set_read_timeout(10 * time.second)
		conn.set_write_timeout(10 * time.second)
		mut upd_receive_com := self.ecs.add_component<NetworkUdpComponent>(self.ecs.root_entity)
		upd_receive_com.c = conn
		//go NetworkServerSystemUdp.listen_server(mut conn)
	}
}


pub fn (mut self NetworkServerSystemUdp) update() {
	for entity in self.ecs.selector().and<NetworkUdpServerComponent>().query() {
		/*
		mut buf := []u8{len: 100}
		read, addr := c.read(mut buf) or { continue }

		ntsc := self.ecs.get_component<NetworkUdpServerComponent>(entity)
		client_entity := ntsc.clinet_map[addr]
		nrbc := self.ecs.add_component<NetworkReceiveBuffComponent>(entity)
		if !client_entity {
			client_entity = self.ecs.create_entity()
			ntsc.clinet_map[addr] = client_entity
			self.ecs.add_component<NetworkReceiveBuffComponent>(entity)
		}
		nrbc.receive_buff.append(read)
		*/
		mut udp_com := self.ecs.get_component<NetworkUdpServerComponent>(entity)
		mut buf := []u8{len: 100, init: 0}
		read, addr := udp_com.conn.read(mut buf) or { continue }
		self.on_recive(buf[..read], addr)
	}
}

pub fn (mut self NetworkServerSystemUdp) on_recive(data []u8, addr &net.Addr) {

}