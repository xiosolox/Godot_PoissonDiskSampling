extends Node

class_name PoissonDisk



export var width = 1024
export var lenght = 1024
export var p_num = 100
export var distance = 500
export var use_distance = false
export var max_try = 30
var rad


func create ():
	
	
	var grid = Array() 
	var p_active = Array()
	var p_out = Array()
	
	var area = distance
	
	if use_distance == false: 
		area  = (width * lenght * 2) / p_num
	
	rad = int(sqrt(area / PI))
	var rad2 = rad * rad
	var R = 3 * rad2
	
	for l in range(int(width / rad) + 2):
		grid.append([])
		for k in range(int(lenght / rad) + 2):
			grid[l].append(Cells.new())
	
	randomize()
	
	p_active.append(Vector2(randi() % (width - 100) + 50 ,randi() % (lenght  - 100) + 50))
	p_out.append(p_active[0])
	
	var grid_pos = Vector2(int (p_active[0].x / rad), int (p_active[0].y / rad) )
	
	grid[grid_pos.x][grid_pos.y].set_point(int(p_active[0].x),int(p_active[0].y),true)
	
	var cicle = true
	
	while (cicle):
		
		randomize()
		
		var act_p = randi() % p_active.size()
		var try = 0
		
		while (try != max_try ):
			
			try += 1
			randomize()
			
			var skip = false
			var a = 2 * PI * randf()
			
			randomize()
			
			var r = sqrt(randf() * R + rad2)
			
			var x_try = int(p_active[act_p].x + (r * cos(a)))
			var y_try = int(p_active[act_p].y + (r * sin(a)))
			if (x_try > (rad / 5) && x_try <= (width - rad / 5) && y_try > (rad / 5)  && y_try <= (lenght - rad / 5)):
				
				grid_pos.x = int (x_try / rad)
				grid_pos.y = int (y_try / rad)
				
				if (grid[grid_pos.x][grid_pos.y].is_point() == false):
					
					var control = []
					
					for m in range(9):
						control.append(false)
						
					if grid_pos.x != grid.size() :
						if grid_pos.y != grid[0].size() :
							
							control[5] = grid[grid_pos.x +1][grid_pos.y].is_point()
							control[7] = grid[grid_pos.x ][grid_pos.y+1].is_point()
							control[8] = grid[grid_pos.x +1][grid_pos.y+1].is_point()
							
							if grid_pos.x != 0 :
								
								control[3] = grid[grid_pos.x - 1][grid_pos.y].is_point()
								control[6] = grid[grid_pos.x - 1][grid_pos.y+1].is_point()
								
								if grid_pos.y != 0 :
									control[0] = grid[grid_pos.x - 1][grid_pos.y - 1].is_point()
									control[1] = grid[grid_pos.x ][grid_pos.y - 1].is_point()
									control[2] = grid[grid_pos.x + 1][grid_pos.y - 1].is_point()
							elif grid_pos.y != 0 :
								control[1] = grid[grid_pos.x ][grid_pos.y - 1].is_point()
								control[2] = grid[grid_pos.x + 1][grid_pos.y - 1].is_point()
						else :
							control[2] = grid[grid_pos.x + 1][grid_pos.y - 1].is_point()
							control[1] = grid[grid_pos.x ][grid_pos.y - 1].is_point()
							control[5] = grid[grid_pos.x +1][grid_pos.y].is_point()
							if grid_pos.x != 0 :
								
								control[3] = grid[grid_pos.x - 1][grid_pos.y].is_point()
								control[0] = grid[grid_pos.x - 1][grid_pos.y - 1].is_point()
								
					else:
						
						control[3] = grid[grid_pos.x - 1][grid_pos.y].is_point()
						
						if grid_pos.y != grid[0].size() :
							
							control[7] = grid[grid_pos.x ][grid_pos.y+1].is_point()
							control[6] = grid[grid_pos.x - 1][grid_pos.y+1].is_point()
							
							if grid_pos.y != 0:
								
								control[0] = grid[grid_pos.x - 1][grid_pos.y - 1].is_point()
								control[1] = grid[grid_pos.x ][grid_pos.y - 1].is_point()
							
					
					for k in range (control.size()):
						if control[k] :
							var vec = Vector2()
							
							match k:
								0:
									vec = grid[grid_pos.x -1][grid_pos.y -1].get_point()
								1:
									vec = grid[grid_pos.x][grid_pos.y -1].get_point()
								2:
									vec = grid[grid_pos.x +1][grid_pos.y -1].get_point()
								3:
									vec = grid[grid_pos.x -1][grid_pos.y ].get_point()
								5:
									vec = grid[grid_pos.x +1][grid_pos.y ].get_point()
								6:
									vec = grid[grid_pos.x -1][grid_pos.y +1].get_point()
								7:
									vec = grid[grid_pos.x][grid_pos.y +1].get_point()
								8:
									vec = grid[grid_pos.x +1][grid_pos.y +1].get_point()
								_:
									continue
							
							var res = vec.distance_to(Vector2(x_try,y_try))
							
							if res < 0 :
								res = res * -1
								
							if res < rad :
								skip = true
								break
					
					if skip == true:
						continue
					
					p_active.append(Vector2(x_try,y_try))
					p_out.append(Vector2(x_try,y_try))
					grid[grid_pos.x][grid_pos.y].set_point(x_try,y_try,true)
					break
				else:
					continue
		
		if try == max_try :
			p_active.remove(act_p)
		if p_active.size() == 0:
			cicle = false
	
	return (p_out)