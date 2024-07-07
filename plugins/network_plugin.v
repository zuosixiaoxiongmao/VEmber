module plugins

import ember.core {Ecs, System}
import ember.utilities
import ember.parts.network {NetworkUdpServerComponent,NetworkServerSystemUdp, NetworkUdpComponent, NetworkUdpReceiveSystem, NetworkServerSystemTcp, NetworkTcpServerComponent, NetworkClientSystem , NetworkReceiveBuffComponent, NetworkClientComponent}

struct NetworkPlugin {

}

pub struct NetworkServerSystemUdpExt {
	NetworkServerSystemUdp
}

pub fn NetworkPlugin.start_server(context core.Context) {
	mut ecs := context.ecs
	entity := ecs.root_entity

	ecs.add_component<NetworkUdpServerComponent>(entity)
	ecs.add_system<NetworkServerSystemUdpExt>()

}

pub fn NetworkPlugin.start_client_receive(context core.Context) {
	mut ecs := context.ecs
	for entity in ecs.selector().and<NetworkReceiveBuffComponent>().query() {
		ntrc := ecs.get_component<NetworkReceiveBuffComponent>(entity)
		if 0 < ntrc.receive_buff.len {
			//parse_message(ntrc.receive_buff)
		}
	}
}

pub fn connecting(context core.Context, ip string, port string) {
	mut ecs := context.ecs
	entity := ecs.root_entity
	mut ncc := ecs.add_component<NetworkClientComponent>(entity)
	ncc.url = ip + ":" + port
	ecs.add_system<NetworkClientSystem>()
}

pub fn NetworkPlugin.start(context core.Context) {
	mut ecs := context.ecs
	entity := ecs.root_entity

	ecs.add_component<NetworkTcpServerComponent>(entity)
	ecs.add_system<NetworkServerSystemTcp>()


	NetworkPlugin.start_server(context)
	NetworkPlugin.start_client_receive(context)
	connecting(context, "127.0.01", "12234")
	
}
