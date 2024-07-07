module network

import core {Ecs, System, Entity}

[heap]
pub struct NetworkReceiveBuffComponent {
	pub mut:
		receive_buff []u8=[]
}
