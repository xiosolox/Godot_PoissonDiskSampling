extends Node


class_name Cells

var x = 0
var y = 0
var point = false


func getposition():
	return(Vector2(x,y))
	

func is_point():
	return point

func get_point():
	return (Vector2(x,y))

func set_point(x_point,y_point,new_point = true):
	x = x_point
	y = y_point
	point = new_point

