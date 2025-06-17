extends Node2D

@export var move_speed := 10              # pixels per second
@export var move_down_amount := 5        # how much to drop when hitting screen edge
@export var direction := 1                # 1 = right, -1 = left

@export var alien_width := 12
@export var alien_height := 8
@export var spacing := 2
@export var columns := 8
@export var rows := 6

@onready var alien_ticker = $AlienTicker

var grid_size : Vector2

var just_moved_down := false

func _ready():
	grid_size = Vector2(
		columns * alien_width + (columns - 1) * spacing,
		rows * alien_height + (rows - 1) * spacing
	)
	center_on_screen()


func center_on_screen():
	var screen_size = get_viewport_rect().size
	position = Vector2( (screen_size.x - grid_size.x) / 2, 6 )


func _on_alien_ticker_timeout():
	var screen_width = get_viewport_rect().size.x - 12
	var right_edge = position.x + grid_size.x
	var left_edge = position.x - 6

	# Check if we hit the screen edge
	if (direction == 1 and right_edge >= screen_width) or (direction == -1 and left_edge <= 0):
		if not just_moved_down:
			position.y += move_down_amount
			direction *= -1
			just_moved_down = true
	else:
		position.x += move_speed * direction
		just_moved_down = false
	
	if just_moved_down:
		print( "Old Timer: "+str(alien_ticker.wait_time))
		alien_ticker.wait_time -= 0.1
		print( "New Timer: "+str(alien_ticker.wait_time))
