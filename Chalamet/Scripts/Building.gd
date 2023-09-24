class_name Building
extends Node3D

@export var inPlacement : bool = true

var _GM : GameManager
var _yOffset : float = 8.471

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (inPlacement):
		position = _GM._currentSelectedTile.position
		position.y += _yOffset
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			inPlacement = false
			$MeshInstance3D2.visible = false
			$RigidBody3D.freeze = false
