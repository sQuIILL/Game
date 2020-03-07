extends Actor

onready var sprite = get_node("sprite")
var anim = "Idle0"

func _physics_process(delta: float) -> void:
	var direction:= get_direction()
	_velocity = calculate_move_velocity(_velocity,direction,speed)
	_velocity= move_and_slide(_velocity, FLOOR_NORMAL)
	print(_velocity.x)
	if _velocity.x == 0:
		anim="Idle0"
	else:
		anim="Running"
	if _velocity.x > 0:
		sprite.set_flip_h(false)
	elif _velocity.x < 0:
		sprite.set_flip_h(true)
	sprite.play(anim)

func get_direction()-> Vector2:
	return Vector2(Input.get_action_strength("move_right")-Input.get_action_strength("move_left"),
	Input.get_action_strength("move_down")-Input.get_action_strength("move_up"))

func calculate_move_velocity(liner_velocity: Vector2, direction: Vector2, speed)->Vector2:
	var out= liner_velocity
	out.x = speed.x*direction.x
	out.y = speed.y*direction.y
	return out
