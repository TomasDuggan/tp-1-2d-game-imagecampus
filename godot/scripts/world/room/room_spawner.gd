extends Node
class_name RoomSpawner

@export_category("Editor Dependencies")
@export var _rooms_container: Node2D
@export var _main_ground_tilemap: MainGroundTileMap

signal interactable_room_spawned(amount_of_interactables: int)

const VIEWPORT_HEIGHT := 720.0
const ROOM_SPAWN_MARGIN := 50.0

var _room_picker := RoomPicker.new()
var _collectables_to_spawn: Array[CollectableConfig] = []
var _rooms_height_accumulator := 0.0


func initialize(world_type: World.WorldType) -> void:
	_room_picker.interactable_room_spawned.connect(interactable_room_spawned.emit)
	_room_picker.end_room_spawned.connect(_on_end_room_spawned, CONNECT_ONE_SHOT)
	add_child(_room_picker)
	_room_picker.initialize(world_type)
	
	_main_ground_tilemap.initialize(world_type)
	
	_collectables_to_spawn = RoomSpawnerConfigHelper.get_valid_collectable_configs(world_type)
	
	_spawn_room(Vector2(0, VIEWPORT_HEIGHT + ROOM_SPAWN_MARGIN))

func _on_end_room_spawned() -> void:
	set_process(false)

func _process(_delta: float) -> void:
	if _room_reached_end():
		_spawn_room()

"""
Explicacion x las dudas
* _rooms_height_accumulator: Acumula el size.y de los rooms, es la Y del próximo room a spawnear en coordenadas del container. 
* -_rooms_container.position.y: La parte superior del container, se mueve con el scroll.
* Restar VIEWPORT_HEIGHT: spawn justo cuando la parte visible alcanza el final del room anterior.
"""
func _room_reached_end() -> bool:
	return _rooms_height_accumulator > -_rooms_container.position.y - VIEWPORT_HEIGHT - ROOM_SPAWN_MARGIN


func _spawn_room(pos: Vector2 = Vector2(0, -ROOM_SPAWN_MARGIN)) -> void:
	var room_config: RoomConfig = _room_picker.pick_room()
	var room_instance: Room = room_config.scene.instantiate()
	
	room_instance.initialize(_collectables_to_spawn)
	_rooms_container.add_child(room_instance)
	room_instance.global_position = pos
	
	_main_ground_tilemap.add_new_room_ground_tilemap(room_instance.get_map(), _rooms_height_accumulator)
	
	_rooms_height_accumulator -= room_instance.get_room_height()

# Pasamanos
func spawn_interactable_room(amount_of_interactables: int) -> void:
	_room_picker.spawn_interactable_room(amount_of_interactables)




#
