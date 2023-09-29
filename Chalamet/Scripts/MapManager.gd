class_name MapManager
extends Node3D

@export var dimensions : Vector2i

@export var _GM : GameManager

var _allTiles: Array[Array]
var _currentSelectedTile : FloorTile
var _currentHoveredTile : FloorTile

func TempGenerateMap():
	pass
	
func _ready():
	#TODO MF: Create your own class for 2d Arrays, because this is NASTY
	var tilePrefab = preload("res://Prefabs/Tiles/floor_tile.tscn")
	var forestPrefab = preload("res://Prefabs/Tiles/forest_tile.tscn")
	_allTiles.resize(dimensions.x)
	for i in range(dimensions.x):
		_allTiles[i].resize(dimensions.y)
		for j in range(dimensions.y):
			var rand = randi_range(0, 2)
			var newTile: FloorTile
			#TODO MF: This is just intended for tests purposes
			#Replace this with an actual map/biome generation
			if (rand != 2):
				newTile = tilePrefab.instantiate()
			else:
				newTile = forestPrefab.instantiate()
			add_child(newTile)
			_allTiles[i][j] = newTile
			newTile.OnTileHovered.connect(OnTileHovered)
			newTile.global_position = Vector3(-50+i*5.1,0.2,50-j*5.1)
			newTile.SetCoordinates(i, j)

func CanPlaceBuilding(origin: Vector2i, building: Building) -> bool:
	if (not HasResourcesNeedsMet(building)):
		return false
	var occupiedBuildingSpace = building.GetRotatedOccupiedEmplacement(origin)
	for space in occupiedBuildingSpace:
		if not (dimensions.x > space.x && 0 <= space.x && 
		dimensions.y > space.y && 0 <= space.y):
			return false
		if (_allTiles[space.x][space.y].m_isOccupied):
			return false
	return true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func OnTileHovered(floorTile: FloorTile):
	_currentHoveredTile = floorTile
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

func GetAdjacentTiles(coordinates: Vector2i) -> Array[FloorTile]:
	var returnValue: Array[FloorTile] = []
	
	if (coordinates.x - 1 > 0):
		returnValue.append(_allTiles[coordinates.x-1][coordinates.y])
	if (coordinates.x + 1 <= dimensions.x-1):
		returnValue.append(_allTiles[coordinates.x+1][coordinates.y])
	if (coordinates.y + 1 <= dimensions.y-1):
			returnValue.append(_allTiles[coordinates.x][coordinates.y+1])
	if (coordinates.y - 1 > 0):
		returnValue.append(_allTiles[coordinates.x][coordinates.y-1])
	return returnValue

func HasResourcesNeedsMet(building: Building):
	var resourcesRequired = building._buildingData.ResourcesRequired
	if (resourcesRequired.size() == 0
		|| resourcesRequired.size() == 1 
		&& resourcesRequired[0] == GlobalEnums.EResourceType.NONE):
			return true
	else:
		var adjacentTiles = GetAdjacentTiles(_currentHoveredTile.m_coordinates)
		for resourceRequired in resourcesRequired:
			if not HasResourceAdjacent(resourceRequired, adjacentTiles):
				return false
	return true

func HasResourceAdjacent(resourceType: GlobalEnums.EResourceType, tiles: Array[FloorTile]) -> bool:
	if resourceType == GlobalEnums.EResourceType.NONE:
		return true
	for tile in tiles:
		if resourceType == tile.resourceType:
			return true
	return false
