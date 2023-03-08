extends Camera2D

const SHAKE_EXPONENT := 1.8

export var max_zoom := 5.0
export var decay_rate := 1.0
export var max_offset := Vector2(100.0, 100.0)
export var max_rotation := 0.1

var shake_amount := 0.0 setget set_shake_amount
var noise_y := 0.0

var _start_zoom := zoom
var _start_position := Vector2.ZERO

onready var tween := $Tween
onready var noise := OpenSimplexNoise.new()


func _ready() -> void:
	set_physics_process(false)

	Events.connect("shake_camera", self, "_on_Events_shake_camera")

	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2


func _physics_process(delta):
	self.shake_amount -= decay_rate * delta
	shake()




func set_shake_amount(value):
	shake_amount = clamp(value, 0.0, 1.0)
	set_physics_process(shake_amount != 0.0)


func _on_Events_shake_camera(amount) -> void:
	self.shake_amount += amount

This is my test to know if it works