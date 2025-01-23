extends Node2D


@onready var pick_ups: Node = $PickUps


var _pickups_count: int = 0
var _collected: int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_pickups_count = pick_ups.get_children().size()
	SignalManager.on_pickup.connect(on_pickup)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func check_show_exit():
	if _collected == _pickups_count:
		SignalManager.on_show_exit.emit()
		
		
func on_pickup():
	print("on_pickup")
	_collected += 1
	check_show_exit()
	
	
