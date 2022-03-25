extends Control


# Função que controla a musica de cada personagem
func _musica():
	if(ScriptGlobal.status_music == true):
		if(ScriptGlobal.personagem == 1):
			if(not $Music_naruto.playing):
				$Music_naruto.play()
		else:
			if(not $Music_sasuke.playing):
				$Music_sasuke.play()
	else:
		$Music_naruto.stop()
		$Music_sasuke.stop()

# Função que controla a fala de cada personagem
func _som_fala():
	if(ScriptGlobal.status_som == true):
		if(ScriptGlobal.personagem == 1):
			$Som_fala_naruto.play()
		else:
			$Som_fala_sasuke.play()
	else:
		$Som_fala_naruto.stop()
		$Som_fala_sasuke.stop()

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
	$Img_naruto.visible = false
	$Img_sasuke.visible = false
	
	_musica()
	
	if(ScriptGlobal.personagem == 1):
		$Img_naruto.visible = true
	else:
		$Img_sasuke.visible = true
	pass


#--- verifica se pode tocar musica ---
func _process(delta):
	_musica()
	pass

#--- Quando apertar o botão ---
func _on_Butt_Inicio_pressed():
	_som_press()
	get_tree().change_scene("res://Cenas/Menu/cena_menu.tscn")
	pass

#--- Tempo para liberar a fala ---
func _on_Timer_timeout():
	_som_fala()
	pass 

# --- Quando passa o mouse por cima ---
func _on_Butt_Inicio_mouse_entered():
	_som_selec()
	pass 
