extends CharacterBody2D

@export var speed: float = 80.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var last_direction := Vector2.DOWN


func _ready():
	z_index = 10
	anim.play("idle_down")


func _physics_process(_delta):
	var input_vector := Vector2.ZERO

	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		last_direction = input_vector
		velocity = input_vector * speed
		play_walk(input_vector)
	else:
		velocity = Vector2.ZERO
		play_idle(last_direction)

	move_and_slide()


func play_walk(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim.play("walk_right")
		else:
			anim.play("walk_left")
	else:
		if direction.y > 0:
			anim.play("walk_down")
		else:
			anim.play("walk_up")


func play_idle(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			anim.play("idle_right")
		else:
			anim.play("idle_left")
	else:
		if direction.y > 0:
			anim.play("idle_down")
		else:
			anim.play("idle_up")
