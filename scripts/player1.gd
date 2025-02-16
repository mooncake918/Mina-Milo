extends CharacterBody2D

@export var speed: float = 200.0
@export var wall_jump_force: Vector2 = Vector2(250, -250)  # X for push, Y for jump
@export var gravity: float = 800.0

var can_wall_jump: bool = false
var wall_direction: int = 0

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_cat_audio: AudioStreamPlayer2D = $JumpCatAudio

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump1") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_cat_audio.reparent(get_tree().current_scene)
		jump_cat_audio.play()
	
	if Input.is_action_just_pressed("jump1"):  # "ui_accept" is usually Spacebar
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_cat_audio.reparent(get_tree().current_scene)
			jump_cat_audio.play()
		elif can_wall_jump:  # Perform wall jump
			velocity = Vector2(-wall_direction * wall_jump_force.x, wall_jump_force.y)
			can_wall_jump = false
			
	if not is_on_floor() and (is_on_wall() or test_wall_collision()):
		can_wall_jump = true
		wall_direction = 1 if get_wall_normal().x < 0 else -1  # Detect wall side
	
	# Get input direction: -1, 0, 1
	var direction := Input.get_axis("move_left1", "move_right1")
	
	# Flip direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func test_wall_collision() -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(velocity.x * 0.1, 0), 1)
	var result = space_state.intersect_ray(query)
	return result.size() > 0
