extends Area2D

var dir = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += 3*dir
	
	if position.y > 500  :
		dir = dir*-1
	if position.y < 200 :
		dir = abs(dir)


func _on_body_entered(body):
	print(body.get_name())
	body.get_parent().game_running = false
