extends Control

# Função que controla a musica de cada personagem
func _musica():
	if(ScriptGlobal.status_music == true):
		if(not $Music.playing && ScriptGlobal.loading_som == true):
			$Music.play()
			$Timer.start()
			$Anima.stop()
			$Img_game_over/Naruteiro.visible = false
			$Img_game_over/Susukeiro.visible = false
		if($Music.playing && ScriptGlobal.loading_som == false):
			$Music.stop()
		
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
	ScriptGlobal.cenario_excluir = true
	ScriptGlobal.pause_excluir = true
	ScriptGlobal.loading = 1
	ScriptGlobal.loading_som = true
	$Img_game_over/Naruteiro.visible = false
	$Img_game_over/Susukeiro.visible = false
	_musica()

func _process(delta):
	_musica()


#--- Quando apertar o botão ---
func _on_Butt_Inicio_pressed():
	_som_press()
	ScriptGlobal.venceu = false
	ScriptChangeLoading.ir_para("res://Cenas/Menu/cena_menu.tscn", self)
	ScriptGlobal.loading_som = false
	


# --- Quando passa o mouse por cima ---
func _on_Butt_Inicio_mouse_entered():
	_som_selec()


#--- meme ---
func _on_Timer_timeout():
	$Anima.play("inicio")
	print("deu bom")


# --- meme ---
func _on_Anima_animation_finished(anim_name):
	
	if (anim_name == "inicio"):
		$Anima.play("batidafinal")
	
