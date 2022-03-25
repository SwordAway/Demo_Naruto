extends Control

	
	
func _dispositivo_on():
	if(ScriptGlobal.dispositivo == true):
		$Selec_modo_jogo/Multiplayer.visible = false
		$Selec_modo_jogo/Single_player.visible = false
		$Selec_modo_jogo/Single_player2.visible = true
	else:
		$Selec_modo_jogo/Single_player2.visible = false
		$Selec_modo_jogo/Multiplayer.visible = true
		$Selec_modo_jogo/Single_player.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Selec_modo_jogo.visible = false
	_dispositivo_on()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass





func _on_Sair_pressed():
	get_tree().change_scene("res://Cenas/Login/cena_login.tscn")
	pass # Replace with function body.
func _on_Voltar_pressed():
	$Selec_modo_jogo.visible = false
	$Menu_inicial.visible = true
	pass # Replace with function body.
func _on_Jogar_pressed():
	$Menu_inicial.visible = false
	$Selec_modo_jogo.visible = true
	pass # Replace with function body.



#_____________ Som do mouse em cima _____________
func _on_Sair_mouse_entered():
	pass # Replace with function body.
func _on_Voltar_mouse_entered():
	pass # Replace with function body.










func _on_TouchScreenButton_pressed():
	print("mudou hein")
	pass # Replace with function body.
