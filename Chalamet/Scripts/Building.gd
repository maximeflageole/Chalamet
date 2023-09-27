class_name Building
extends Node3D

@export var inPlacement : bool = true
@export var _rb : RigidBody3D
@export var _placementMeshes : Array[MeshInstance3D]
@export var _buildingData : BuildingData

var _GM : GameManager
var _yOffset : float = 8.471
var _currentDirection = 0

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
			if (not _GM.CanPlaceBuilding(self)):
				return
			inPlacement = false
			for mesh in _placementMeshes:
				mesh.visible = false
			_rb.freeze = false
			_GM.OnBuildingPlaced(self)

func Rotate():
	var axis = Vector3(0, 1, 0) # Or Vector3.UP
	var rotation_amount = -90*PI/180
	transform.basis = Basis(axis, rotation_amount) * transform.basis
	_currentDirection += 1
	_currentDirection %= 4

func GetRotatedOccupiedEmplacement(origin: Vector2i) -> Array[Vector2i]:
	#TODO MF: Do I need to say anything here?
	#Well, it's functional...
	var rotatedArray : Array[Vector2i]
	var originalArray = _buildingData.OccupiedSpace
	var sqrt = sqrt(originalArray.size())
	
	if (_currentDirection == 0):
	##Cas non rotated
		for i in range(sqrt):
			for j in range(sqrt):
				if (originalArray[i*sqrt + j] == true):
					rotatedArray.append(Vector2i(origin.x + i, origin.y + j))
	if (_currentDirection == 1):
	##Cas 1 rotation
		for i in range(sqrt):
			for j in range(sqrt):
				if (originalArray[i*sqrt + j] == true):
					rotatedArray.append(Vector2i(origin.x + j, origin.y - i))
	if (_currentDirection == 2):
	##Cas 2 rotations
		for i in range(sqrt):
			for j in range(sqrt):
				if (originalArray[i*sqrt + j] == true):
					rotatedArray.append(Vector2i(origin.x - i, origin.y - j))
	if (_currentDirection == 3):
	##Cas 3 rotations
		for i in range(sqrt):
			for j in range(sqrt):
				if (originalArray[i*sqrt + j] == true):
					rotatedArray.append(Vector2i(origin.x - j, origin.y + i))
	return rotatedArray
