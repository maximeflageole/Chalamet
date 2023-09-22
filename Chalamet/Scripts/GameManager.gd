class_name GameManager
extends Node3D

@export var myInt = 5
@export var mainUI : MainUI
@export var buildingsData : Array[BuildingData]
@export var dimensions : Vector2i

var _allTiles: Array[FloorTile]
var _currentSelectedTile : FloorTile

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilePrefab = preload("res://Prefabs/floor_tile.tscn")
	for i in range(dimensions.x):
		for j in range(dimensions.y):
			var newTile = tilePrefab.instantiate()
			add_child(newTile)
			_allTiles.append(newTile)
			newTile.OnTileHovered.connect(SetCurrentTile)
			newTile.global_position = Vector3(i,0.2,j)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func OnButtonPressed():
	print(buildingsData[0].test_text)
	
func SetCurrentTile(floorTile: FloorTile):
	_currentSelectedTile = floorTile
	print("Whhaaaaat? I did it?")
