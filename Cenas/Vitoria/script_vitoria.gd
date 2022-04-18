extends Control


# Função que controla a musica de cada personagem
func _musica():
	if(ScriptGlobal.status_music == true):
		if(ScriptGlobal.personagem == 1):
			if(not $Music_naruto.playing && ScriptGlobal.loading_som == true):
				$Music_naruto.play()
			if($Music_naruto.playing && ScriptGlobal.loading_som == false):
				$Music_naruto.stop()
			
		if(ScriptGlobal.personagem == 2):
			if(not $Music_sasuke.playing && ScriptGlobal.loading_som == true):
				$Music_sasuke.play()
			if($Music_sasuke.playing && ScriptGlobal.loading_som == false):
				$Music_sasuke.stop()
		
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
	ScriptGlobal.cenario_excluir = true
	ScriptGlobal.pause_excluir = true
	ScriptGlobal.loading = 1
	ScriptGlobal.loading_som = true
	$Control/Img_naruto.visible = false
	$Control/Img_sasuke.visible = false
	_musica()
	
	if(ScriptGlobal.personagem == 1):
		$Control/Img_naruto.visible = true
	else:
		$Control/Img_sasuke.visible = true



#--- verifica se pode tocar musica ---
func _process(delta):
	_musica()

#--- Quando apertar o botão ---
func _on_Butt_Inicio_pressed():
	_som_press()
	ScriptGlobal.venceu = true
	ScriptChangeLoading.ir_para("res://Cenas/Menu/cena_menu.tscn", self)
	ScriptGlobal.loading_som = false


#--- Tempo para liberar a fala ---
func _on_Timer_timeout():
	_som_fala()
	pass 

# --- Quando passa o mouse por cima ---
func _on_Butt_Inicio_mouse_entered():
	_som_selec()

