module network

import net
import time
import io

enum NetType {
	net_tcp
	net_websocket
	net_udp
}

pub interface IEndPoint {
	mut:
		stream_up()
		stream_down()
}

pub struct TcpEndPoint {
	mut:
		socket &net.TcpConn
		steam_byte []u8 = []
}

pub fn (self TcpEndPoint) stream_up(){

}

pub fn (self TcpEndPoint) stream_down(){
	//received := reader.read_any() or {continue}
	//self.steam_byte.append(received)
}

pub struct UdpEndPoint {
}

pub struct WebSocketEndPoint {
}

pub struct Channel {

}

pub fn Channel.new(ep1 IEndPoint, ep2 IEndPoint ) {

}


pub type ListenerHandleFn = fn (mut endpoint &IEndPoint)

interface IListener {
	mut:
	  listen(url string)
}


pub struct TcpListener {
}


fn (mut self TcpListener)  handle_client(mut socket net.TcpConn) {
	defer {
		socket.close() or { panic(err) }
	}
	bytes := []u8{}
	end_point := &TcpEndPoint{socket,bytes}
	client_addr := socket.peer_addr() or { return }
	eprintln('> new client: ${client_addr}')
	mut reader := io.new_buffered_reader(reader: socket)
	defer {
		unsafe {
			reader.free()
		}
	}
	for {
		//received := reader.read_any() or {continue}
		end_point.stream_down()
	}
}

pub fn (self TcpListener) listen(port string){
	mut server := net.listen_tcp(.ip6, ':' + port) or {panic("tcp listen error!")}
	laddr := server.addr() or {panic("tcp addr error!")}
	eprintln('Listen on ${laddr} ...')
	for {
		mut socket := server.accept() or {panic("tcp accept error!")}
		//spawn handle_client(mut socket)
	}

}

pub struct UdpListener {

}

fn udp_server(mut c net.UdpConn){
	mut count := 0
	for {
		eprintln('> echo_server loop count: ${count}')
		mut buf := []u8{len: 100}
		read, addr := c.read(mut buf) or { continue }
		eprintln('Server got addr ${addr}, read: ${read} | buf: ${buf}')
		c.write_to(addr, buf[..read]) or {
			println('Server: connection dropped')
			return
		}
		time.sleep(1 * time.millisecond)
	}
}

pub fn (self UdpListener) listen(server_addr string){
	mut l := net.listen_udp(server_addr) or { panic('could not listen_udp: ${err}') }
	spawn udp_server(mut l)
}

pub struct KcpListener {

}


pub struct WebSocketListener {

}


interface IConnector {
	mut:
	connecting(url string)
}

pub struct TcpConnector {
	pub mut:
		client &net.TcpConn = voidptr(0)
}

fn (mut self TcpConnector) connecting(url string) !IEndPoint {
	//self.client := net.dial_tcp('localhost${server_port}') or { panic(err) }
	self.client = net.dial_tcp(url) or { panic(err) }
	return self
}

pub fn (self TcpConnector) stream_up(){

}

pub fn (self TcpConnector) stream_down(){
}


pub struct UdpConnector {
	pub mut:
		client &net.TcpConn = voidptr(0)
}

fn (mut self UdpConnector) connecting(url string) !IEndPoint {
	//self.client := net.dial_tcp('localhost${server_port}') or { panic(err) }
	self.client = net.dial_tcp(url) or { panic(err) }
	return self
}

pub fn (self UdpConnector) stream_up(){

}

pub fn (self UdpConnector) stream_down(){
}


pub struct  Network {

}

pub fn Network.create_tcp( url string, handle ListenerHandleFn) !&IListener{
	listener := &TcpListener{}
	listener.listen(url)
	return listener
}

pub fn Network.connecting_tcp(ntype NetType, url string) !&IEndPoint{
	mut connector := &TcpConnector{}
	connector.connecting(url) !
	return connector
}


pub fn Network.create_udp( url string, handle ListenerHandleFn) !&IListener{
	listener := &UdpListener{}
	return listener
}

pub fn Network.connecting_udp( url string) !&IEndPoint{
	mut connector := &UdpConnector{}
	connector.connecting(url)!
	return connector
}