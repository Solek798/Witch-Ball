extends Node2D

func get_by_id(id):
	return get_node("Player%d" % id).position
