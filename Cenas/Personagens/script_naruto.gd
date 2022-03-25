extends KinematicBody2D

var movimento = Vector2(0,-1)
export var velocidade_de_movimento = 480
export var forca_do_pulo = -1000
export var gravidade = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
#	--- Limitando na tela de jogo
	global_position.x = clamp(global_position.x,10,2550)
#	--- Morte do jogador por limite chão
	if(global_position.y > $Camera.limit_bottom):
#		get_tree().change_scene("res://Cenas/Game_over/cena_game_over.tscn")
#		get_tree().change_scene("res://Cenas/Cenarios/cena_cenario_demo.tscn")
		position.y = 0
		position.x = 0
	
	
	movimento.y += gravidade * delta
	var direcao_movimento = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
	movimento.x = velocidade_de_movimento * direcao_movimento
	
	if(is_on_floor() and Input.is_action_just_pressed("cima")):
		movimento.y = forca_do_pulo
	
	elif(is_on_wall() and Input.is_action_just_pressed("cima")):
		movimento.y = forca_do_pulo
		
	movimento = move_and_slide(movimento, Vector2(0,-1))
	
	print(global_position.y)
	print(movimento.y)
	print(is_on_floor())
	print(is_on_wall())
	pass
