extends Node2D


@onready var pick_ups: Node = $PickUps
@onready var game_ui: Control = $CanvasLayer/GameUi


var _pickups_count: int = 0
var _collected: int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_pickups_count = pick_ups.get_children().size()
	game_ui.update_score(_collected, _pickups_count)
	SignalManager.on_pickup.connect(on_pickup)
	SignalManager.on_exit.connect(on_exit)
	SignalManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func stop_all_nodes():
	for n in get_tree().get_nodes_in_group("bullet"):
		n.queue_free()
		
	var p = get_tree().get_first_node_in_group("player")
	p.set_physics_process(false)
	
	for n in get_tree().get_nodes_in_group("npc"):
		n.stop_action()


func on_game_over():
	stop_all_nodes()


func on_exit():
	stop_all_nodes()

func check_show_exit():
	if _collected == _pickups_count:
		SignalManager.on_show_exit.emit()
		
		
func on_pickup():
	print("on_pickup")
	_collected += 1
	game_ui.update_score(_collected, _pickups_count)
	check_show_exit()
	
	
