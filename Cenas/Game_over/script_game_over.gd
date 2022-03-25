extends Control




# Função que controla a musica de cada personagem
func _musica():
	if(ScriptGlobal.status_music == true):
		if(not $Music.playing):
				$Music.play()
				$Timer.start()
				$Anima.stop()
				$Naruteiro.visible = false
				$Susukeiro.visible = false
	else:
		$Music.stop()


# Função de apertar o botão
func _som_press():
	if(ScriptGlobal.status_som == true):
		$Som_press.play()
	else:
		$Som_press.stop()	

# Função de som de selecionar
func _som_selec():
	if(ScriptGlobal.status_som == true):
		$Som_selec.play()
	else:
		$Som_selec.stop()

func _ready():
	$Naruteiro.visible = false
	$Susukeiro.visible = false
	_musica()
	pass

func _process(delta):
	_musica()
	pass

#--- Quando apertar o botão ---
func _on_Butt_Inicio_pressed():
	_som_press()
	get_tree().change_scene("res://Cenas/Menu/cena_menu.tscn")
	pass

# --- Quando passa o mouse por cima ---
func _on_Butt_Inicio_mouse_entered():
	_som_selec()
	pass 

#--- meme ---
func _on_Timer_timeout():
	$Anima.play("inicio")
	print("deu bom")
	pass # Replace with function body.

# --- meme ---
func _on_Anima_animation_finished(anim_name):
	
	if (anim_name == "inicio"):
		$Anima.play("batidafinal")
	
	pass # Replace with function body.
