extends CharacterBody2D

var speed = 4000 # How fast the player moves.

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	player_movement(delta)
	set_player_texture()

func player_movement(delta: float) -> void:
	var movement_direction = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	velocity = movement_direction*speed*delta
	move_and_slide()

func set_player_texture() -> void:
	# Enough spaghetti to feed Italy for 3 years.
	var texture_mode: String = $Texture.animation.split("_")[1]
	# Make the player either stand or walk.
	if velocity == Vector2(0, 0):
		texture_mode = "stand_"+texture_mode
	else:
		texture_mode = "walk"
	
	# Get direction of texture, if there is movement.
	if velocity.x < 0:
		texture_mode += "_left"
	elif velocity.x > 0:	
		texture_mode += "_right"
	elif velocity.y < 0:
		texture_mode += "_up"
	elif velocity.y > 0:
		texture_mode += "_down"

	# Update the animation player.
	$Texture.play(texture_mode)
