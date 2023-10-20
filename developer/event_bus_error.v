import eventbus {EventBus, EventHandlerFn}

fn on_test_with_receiver(receiver &FakeReceiver, ev &EventData, sender voidptr) {
	println('11111111111')
}

struct FakeReceiver {}



fn send<T>(eb &EventBus<u64>, name u64, data voidptr) {
	eb.publish(name, eb, data)
}

struct NetCom {}

struct EventData {
	
}

mut eb := eventbus.new[u64]()
r := &FakeReceiver{}
eb.subscriber.subscribe_method(1, on_test_with_receiver, r)
EventDataeb.publish(1, eb, &EventData{})
send<>( eb, 1, &EventData{})

