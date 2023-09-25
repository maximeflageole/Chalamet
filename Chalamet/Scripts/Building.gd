class_name Building
extends Node3D

@export var inPlacement : bool = true
@export var _rb : RigidBody3D
@export var _placementMesh : MeshInstance3D

var _GM : GameManager
var _yOffset : float = 8.471

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (inPlacement):
		position = _GM.GetCurrentTile().position
		position.y += _yOffset
	
func _input(event):
	if not inPlacement:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if (not _GM.CanPlaceBuilding()):
				return
			inPlacement = false
			_placementMesh.visible = false
			_rb.freeze = false
			_GM.OnBuildingPlaced(self)
