class_name FloorTile

extends Area3D

signal OnTileHovered(floorTile: FloorTile)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered() -> void:
	print("entered")

func _on_mouse_exited():
	print("exited")
