module core

import eventbus {EventBus, EventHandlerFn}
import datatypes as dt

type Entity = u64
type ComponentType = u16
type Signature = BitSet


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
pub interface IComponentArray{
	mut:
	entity_destroyed(entity Entity)
}

struct ComponentArrayBase {}

fn (mut self ComponentArrayBase) entity_destroyed(entity Entity) {
}

pub struct ComponentArray<T> {
	ComponentArrayBase
	mut:
		component_array []T=[]
		entity_to_index_map map[i64]i64={}
		index_to_entity_map map[i64]Entity={}
		size i64
}

fn (mut self ComponentArray<T>) insert_data(entity Entity, component T){
	self.entity_to_index_map[entity] = self.size
	self.index_to_entity_map[self.size] = entity
	self.component_array << component
	self.size++
}

fn (mut self ComponentArray<T>) remove_data(entity Entity){
	index_of_removed_entity := self.index_to_entity_map[entity]
	mut index_of_last_element := self.size - 1
	self.component_array[index_of_removed_entity] = self.component_array[index_of_last_element]

	index_of_last_element = self.index_to_entity_map[index_of_last_element]
	self.entity_to_index_map[index_of_last_element] = index_of_removed_entity
	self.index_to_entity_map[index_of_removed_entity] = index_of_last_element

	self.entity_to_index_map.delete(entity)
	self.index_to_entity_map.delete(index_of_last_element)
}

fn (self ComponentArray<T>) get_data(entity Entity) &T{
	 return &self.component_array[self.entity_to_index_map[entity]]
}

fn (mut self ComponentArray<T>) entity_destroyed(entity Entity) {
	self.remove_data(entity)
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
pub struct EntityManager {
	mut:
	 living_entity_count u64
	 signatures []Signature = []
}

fn (mut self EntityManager) create_entity() Entity {
	entity := self.living_entity_count
	self.signatures << Signature{}
	self.living_entity_count ++ 
	return entity
}

fn (mut self EntityManager) destroy_entity(entity Entity) {
	self.signatures[entity].reset()
	self.living_entity_count--
}

fn (self EntityManager) set_signature<T>(entity Entity, signature Signature)  {
	self.signatures[entity] = signature
}

fn (self EntityManager) get_signature(entity Entity) &Signature {
	return &self.signatures[entity]
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
pub struct ComponentManager {
	mut:
		component_types map[string]ComponentType = {}
		component_arrays map[string]&ComponentArrayBase = {}
		next_component ComponentType
}

fn (mut self ComponentManager) register_component<T>() {
	type_name := typeof[T]().name

	self.next_component++
	self.component_types[type_name] = self.next_component
	self.component_arrays[type_name] =  &ComponentArray<T>{}
	
}

fn (self ComponentManager) get_component_type<T>() ComponentType {
	type_name := typeof[T]().name
	if type_name in self.component_types {
		return self.component_types[type_name]
	}
	 return 0
}

fn (mut self ComponentManager) add_component<T>(entity Entity, component T){
	if 0 == self.get_component_type<T>() {
		self.register_component<T>()
	}
	mut com_arr := self.get_component_array<T>()
	com_arr.insert_data(entity, component)
}

fn (self ComponentManager) remove_component<T>(entity Entity){
	mut com_arr := self.get_component_array<T>()
	com_arr.remove_data(entity)
}

fn (self ComponentManager) get_component<T>(entity Entity) &T{
	mut com_arr := self.get_component_array<T>()
	return com_arr.get_data(entity)
}

fn (mut self ComponentManager) entity_destroyed(entity Entity){
	for _, mut value in self.component_arrays { 
		mut com_arr := &IComponentArray(*value)
		com_arr.entity_destroyed(entity)
	}
}

fn ( self ComponentManager) get_component_array<T>() &ComponentArray<T> {
	type_name := typeof[T]().name
	com_arr := self.component_arrays[type_name]
	arr := &ComponentArray<T>(com_arr)
	return arr
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

pub interface ISystem {
	ecs &Ecs
	mut:
		init()
		update()
		destroy()
		push_message(message voidptr)
		pop_message() voidptr
}

pub struct System {
	pub mut:
		ecs &Ecs
}

pub fn (mut self System)init() {

}

pub fn (mut self System)update() {
	
}

pub fn (mut self System)destroy() {
}

pub fn (mut self System)push_message(message voidptr) {
	//self.messages.push(message)
}

pub fn (self System)pop_message() voidptr {
	return voidptr(0)
}

pub fn (self System)selector() Selector{
	return self.ecs.selector()
}


pub struct MSystem {
	System
	//mut:
	//	messages dt.Queue[voidptr]
}


pub fn (mut self MSystem)push_message(message voidptr) {
	//self.messages.push(message)
}

pub fn (self MSystem)pop_message() voidptr {
	return voidptr(0)
}


pub struct SystemManager {
	mut:
		system_array map[string]ISystem = {}
}

fn (mut self SystemManager) update(){
	for _, mut sys in self.system_array {
		sys.update()
	}
}

fn (mut self SystemManager) add_system<T>() &T{
	mut t := T{}
	self.system_array[typeof[T]().name] = t
	return &t
}

fn (mut self SystemManager) remove_system<T>(){
	self.system_array[typeof[T]().name].destroy()
	self.system_array.delete(typeof[T]().name)
}

/////////////////////////////////////////////////////////////////////////////

[heap]
struct Selector {
		ecs &Ecs
	mut: 
		signature &Signature

}

pub fn (self Selector) query() []Entity  {
	mut entities := []Entity
	for k, s in self.ecs.entity_manager.signatures {
		if s == self.signature {
			entities << k
		}
	}
	return entities
}

pub fn (self Selector) and<T>() Selector  {
	mut selector := Selector{ecs:self.ecs, signature:self.signature}
	selector.signature.set(selector.ecs.component_manager.get_component_type<T>())
	return selector
}

////////////////////////////////////////////////////////////////////////////

type EventType = u64

[heap]
pub struct Ecs {
	mut:
		entity_manager EntityManager
		component_manager ComponentManager
		system_manager SystemManager
		event_bus EventBus[ComponentType]
}

pub fn Ecs.new() &Ecs {
	mut ecs := &Ecs{}
	ecs.event_bus = eventbus.new[ComponentType]()
	return ecs
}

pub fn (mut self Ecs) create_entity() Entity {
	return self.entity_manager.create_entity()
}

pub fn (mut self Ecs) destroy_entity(entity Entity) {
	self.entity_manager.destroy_entity(entity)
	self.component_manager.entity_destroyed(entity)
}

pub fn (mut self Ecs) add_component<T>(entity Entity){
	component_type := self.component_manager.get_component_type<T>()
	mut signature := self.entity_manager.get_signature(entity)
	signature.set(component_type)
	self.component_manager.add_component<T>(entity, T{})
}

pub fn (self Ecs) remove_component<T>(entity Entity){
	self.component_manager.remove_component<T>(entity)
}

pub fn (self Ecs) get_component<T>(entity Entity) &T{
	return self.component_manager.get_component<T>(entity)
}

pub fn (mut self Ecs) add_system<T>(){
	mut system := self.system_manager.add_system<T>()
	system.ecs = &self
	system.init()
}

pub fn ( self Ecs) remove_system<T>(){
	self.system_manager.remove_system<T>()
}

pub fn (mut self Ecs) update(){
	self.system_manager.update()
}

pub fn ( self Ecs) selector() Selector{
	signature := &Signature{}
	return Selector{ecs:&self, signature:signature}
}

pub fn ( self Ecs) send<T>(entity Entity, m voidptr) {
	com_type := self.component_manager.get_component_type<T>()
	self.event_bus.publish(com_type, self.event_bus, m)
}

pub fn ( self Ecs) call<T, M>(entity Entity, m M) {
	com_type := self.component_manager.get_component_type<T>()
	//self.event_bus.publish(com_type, self.event_bus, m)
}