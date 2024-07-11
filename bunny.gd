extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y < 400:
		position.y += gravity * delta
	



	
	


func _on_body_entered(body):
	position.y = 000
	print(body.get_name())
	body.get_parent().game_running = false
