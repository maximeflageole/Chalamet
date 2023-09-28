class_name BuildingData
extends Resource

enum EResource {MINE, FOREST, NOTHING}

##The array size must be a square number. It's x and y dimensions are the same
@export var OccupiedSpace: Array[bool]
@export var ResourcesRequired : Array[EResource] = [EResource.NOTHING]

func HasConditionsMet() -> bool:
	return (ResourcesRequired.size() == 1 && 
		ResourcesRequired[0] == EResource.NOTHING)
