extends Node2D


onready var poisson = get_node("PoissonDisk")


func _ready():
	pass
	

func _draw():
	print_poisson()


func print_poisson():
	var result = poisson.create()
	for i in result:
		draw_circle(i,1,Color(1,1,1,1))



func _on_Button_pressed():
	update()
