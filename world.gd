extends Node2D
var bush = preload("res://bush.tscn")
var rock = preload("res://rock.tscn")
var log = preload("res://log.tscn")
var obs_type = [bush,rock,log]
var obstacle : Array
var last_obs
const player_start_pos = Vector2i(131,461)
const cam_start_pos = Vector2i(574,287)
const start_speed = 10.0
const max_speed = 30
var game_running : bool
var ground_height : int
var speed : int
var score : int
var highscore : int
var screen_size : Vector2i
var max_difficulty : int = 3
var difficulty :int 
var smth = 0
func _ready():
	screen_size = get_window().size
	ground_height = $ground.get_node("Sprite2D").texture.get_height()
	
	new_game()
	
	
	

func new_game():
	$Player.position = player_start_pos
	$Player.velocity = Vector2i(0,0)
	$Camera2D.position = cam_start_pos
	$ground.position = Vector2i(0,0)	
	difficulty = 0
	score = 0
	game_running = true
	$HUD.get_node("Score3").hide()


func _process(delta):
	
	if game_running:
		
		speed = start_speed + score/10000
		if speed>=max_speed:
			speed = max_speed
		update_diff()	
		generate_obs()	
		$Player.position.x += speed
		
		$Camera2D.position.x += speed
		score += speed
		show_score()
		
		if $Camera2D.position.x - $ground.position.x > screen_size.x *1.5:
			$ground.position.x += screen_size.x
		
		if Input.is_action_just_pressed("cheat"):\
			score += 10000	
			
	else:		
		if Input.is_action_just_pressed("play") and !game_running:
			new_game()
			$HUD.get_node("Score3").hide()

func show_score():
	
	$HUD.get_node("Score").text = "Score : " + str(score/10)
	if score>highscore:
		highscore = score
		$HUD.get_node("Score2").text = "HighScore : " + str(highscore/10)
func generate_obs():
	if obstacle.is_empty() or last_obs.position.x < score + randi_range(300,500+smth) :
		
		var type = obs_type.pick_random()
		var obs
		
		for i in range(randi() % (difficulty + 1)):
			obs = type.instantiate()
			var obs_height = obs.get_node("Sprite2D").texture.get_height()
			var obs_scale = obs.get_node("Sprite2D").scale
			var obs_x: int = screen_size.x + score +  100*i
			
			var obs_y: int = screen_size.y - ground_height + (obs_height * obs_scale.y/2)/2
			
			last_obs = obs
			
			add_obs(obs,obs_x,obs_y)
		
func add_obs(obs,x,y):
	obs.position = Vector2i(x,y)
	add_child(obs)
	obstacle.append(obs)
func update_diff():
	difficulty = score/10000 + 1
	
	
	if difficulty > max_difficulty:
		difficulty = max_difficulty
		smth +=0.1
	else:
		smth+=0.01	
	
func gameover():
	game_running = false
	$HUD.get_node("Score3").show()
	if Input.is_action_just_pressed("play") and !game_running:
			new_game()
			
