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
		area  = (width * lenght  * 2 ) / p_num
		
	
	rad = sqrt(area / PI)
	var rad2 = rad * rad
	var R = 3 * rad2
	var cellsize = int(rad / sqrt(2))
	
	for l in range(int(width / cellsize ) +1):
		grid.append([])
		for k in range(int(lenght / cellsize) +1):
			grid[l].append(-1)
	
	randomize()
	
	#create the first point and add it in the grid
	p_active.append(Vector2(randi() % (width - 100) + 50 ,randi() % (lenght  - 100) + 50))
	p_out.append(p_active[0])
	
	var grid_pos = Vector2(int (p_active[0].x / cellsize), int (p_active[0].y / cellsize) )
	
	grid[grid_pos.x][grid_pos.y] = 0
	

	
	while (p_active.size() != 0 ): 
		
		randomize()
		
		var act_p = randi() % p_active.size()
		var try = 0
		
		while (try != max_try ):
			
			try += 1
			
			randomize()
			
			var skip = false
			var a = randi() % 360
			
			randomize()
			
			var r = (randi() % int(rad)) + rad  
			
			var x_try = int(p_active[act_p].x + (r * cos(a)))
			var y_try = int(p_active[act_p].y + (r * sin(a)))
			
			#check if the point it`s inside the range - radius / 5 
			if (x_try > (rad / 4) && x_try <= (width - rad / 4) && y_try > (rad / 4)  && y_try <= (lenght - rad / 4)):   
				
				
				grid_pos.x = int (x_try / cellsize)
				grid_pos.y = int (y_try / cellsize)
				
				if (grid[grid_pos.x][grid_pos.y] == -1):
					
					# test if the generated point it`s valid
					
					var test = [Vector2(-1,-1), Vector2(-1,0), Vector2(-1,+1), Vector2(0,-1),
					Vector2(0,0), Vector2(0,+1),Vector2(+1,-1), Vector2(+1,0),Vector2(+1,+1)
					,Vector2(-2,0),Vector2(0,+2),Vector2(+2,0),Vector2(0,-2)]
					
					var control = []
					
					for i in test :
						var testx = grid_pos.x + i.x
						var testy = grid_pos.y + i.y
						if testx < 0 || testx > grid.size() -1 || testy < 0 || testy > grid[0].size() -1:
							continue
						if grid[testx][testy] != -1:
							control.append(grid[testx][testy])
						
					if !control.empty():
						for i in control:
							
							var res = p_out[i].distance_to(Vector2(x_try,y_try))
							if res < 0 :
								res = res * -1
								
							if res < rad :
								skip = true
								break
						if skip :
							continue
					p_active.append(Vector2(x_try,y_try))
					p_out.append(Vector2(x_try,y_try))
					grid[grid_pos.x][grid_pos.y] = p_out.size() -1 
					
					
				else:
					continue
		if try == max_try :
			p_active.remove(act_p)
	
	return (p_out)
	
