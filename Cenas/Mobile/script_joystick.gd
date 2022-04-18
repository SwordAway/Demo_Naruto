extends TouchScreenButton

#onready var area_fundo = $Fundo
#onready var area_dentro = $Fundo/Dentro
#
#onready var max_distancia = $Colli_joystick.shape.radius
#
#var toque = false
#var joy_mov = Vector2(0,0)
#
## Identificar se o toque for touch e verificar se está mexendo
#func _input(event):
#	if(event is InputEventScreenTouch):
#		var distance = event.position.distance_to(area_fundo.global_position)
#		if(not toque):
#			if(distance < max_distancia):
#				toque = true
#		else:
#			area_dentro.position = Vector2(0,0) # Quando não tiver tocando ele vai trazer a bolinha pro meio
#			toque = false
#
#func _process(delta):
#	if(toque):
##		Travar a bolinha dentro do circulo maior, usando clamp
#		area_dentro.global_position = get_global_mouse_position()
#		area_dentro.position = area_fundo.position + (area_dentro.position - area_fundo.position).clamped(max_distancia)
#	joy_mov.x = area_dentro.position.x / max_distancia
#	ScriptGlobal.mov_joystick = joy_mov.x

