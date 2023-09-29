class_name BuildingData
extends Resource

##The array size must be a square number. It's x and y dimensions are the same
@export var OccupiedSpace: Array[bool]
@export var ResourcesRequired : Array[GlobalEnums.EResourceType] = [GlobalEnums.EResourceType.NONE]
