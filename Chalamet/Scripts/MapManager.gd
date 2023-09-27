class_name MapManager
extends Node3D

@export var dimensions : Vector2i

@export var _GM : GameManager

var _allTiles: Array[Array]
var _currentSelectedTile : FloorTile

func _ready():
	#TODO MF: Create your own class for 2d Arrays, because this is NASTY
	var tilePrefab = preload("res://Prefabs/floor_tile.tscn")
	_allTiles.resize(dimensions.x)
	for i in range(dimensions.x):
		_allTiles[i].resize(dimensions.y)
		for j in range(dimensions.y):
			var newTile = tilePrefab.instantiate()
			add_child(newTile)
			_allTiles[i][j] = newTile
			newTile.OnTileHovered.connect(TrySetCurrentTile)
			newTile.global_position = Vector3(-50+i*5.1,0.2,50-j*5.1)
			newTile.SetCoordinates(i, j)

func CanPlaceBuilding(origin: Vector2i, building: Building) -> bool:
	var occupiedBuildingSpace = building.GetRotatedOccupiedEmplacement(origin)
	for space in occupiedBuildingSpace:
		if (_allTiles[space.x][space.y].m_isOccupied):
			return false
	return true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func TrySetCurrentTile(floorTile: FloorTile):
	if (_GM._buildingInPlacement == null):
		_currentSelectedTile = floorTile
		return
	if (not floorTile.m_isOccupied && CanPlaceBuilding(floorTile.m_coordinates, _GM._buildingInPlacement)):
		_currentSelectedTile = floorTile

func GetCurrentTile() -> FloorTile:
	return _currentSelectedTile
	
func PlaceBuilding(building: Building):
	#TODO MF: Clean this
	var occupiedSpace = building._buildingData.OccupiedSpace
	var actualOccupiedSpace = building.GetRotatedOccupiedEmplacement(_currentSelectedTile.m_coordinates)
	for value in actualOccupiedSpace:
		_allTiles[value.x][value.y].PlaceBuilding(building)
	pass
