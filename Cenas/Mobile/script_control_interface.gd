extends CanvasLayer



# TEMPORARIAMENTE DESATIVADO (JOYSTICK)
#onready var bolinha_dentro = $Control/Joystick/Bolinha_dentro
#var move = Vector2(0,0)
#var toque = false

# Iniciando para identificar se está tendo um toque na tela e se o toque for seguido de arrastar
#func _input(event):
#	if(event is InputEventScreenTouch or event is InputEventScreenDrag):
#		if($Control/Joystick.is_pressed()): # se estiver tocando na tela
#			move = _calcular_vetor_move(event.position)
#			toque = true
#			bolinha_dentro.visible = true
#			bolinha_dentro.position = event.position + (bolinha_dentro.position - event.position).clamped($Control/Joystick.shape.radius)
#	if(not $Control/Joystick.is_pressed()):
#			bolinha_dentro.position = event.position
#			move = Vector2(0,0)
#
#func _calcular_vetor_move(event_position):
#	var bola_centro = $Control/Joystick.position + Vector2(32,32)
#	return (event_position - bola_centro).normalized()



func _ready():

	if(ScriptGlobal.run == true):
		$Control/Andando.visible = false
		$Control/Correr.visible = true
	else:
		$Control/Correr.visible = false
		$Control/Andando.visible = true


func _process(delta):
	
#	if(move.x < 0):
#		move.x = -1
#	if(move.x > 0):
#		move.x = 1
#	ScriptGlobal.mov_joystick = move.x
	
	if(ScriptGlobal.dispositivo):
#		if(ScriptGlobal.joystick):
#			$Control/Esquerda.visible = false
#			$Control/Direita.visible = false
#			$Control/Joystick.visible = true
#		else:
#			$Control/Joystick.visible = false
#			$Control/Esquerda.visible = true
#			$Control/Direita.visible = true
		
#			Controlando pra correr
		if(ScriptGlobal.run == true):
			$Control/Andando.visible = false
			$Control/Correr.visible = true
		else:
			$Control/Correr.visible = false
			$Control/Andando.visible = true
		
		if(ScriptGlobal.personagem != 2):
			$Control/Jutsu_3.visible = false
		else:
			$Control/Jutsu_3.visible = true
		
	else:
		$Control.visible = false
		

	

