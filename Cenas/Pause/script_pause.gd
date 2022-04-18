extends Control


# ____________ Função de pause _________
func _pause():
	_pause_som()
	if (get_tree().paused == false):
		get_tree().paused = true
		$".".visible = true
	else:
		get_tree().paused = false
		$".".visible = false

#_____________ controlando checkbox das config _____________
func _controle_checks():
	if(ScriptGlobal.status_music == true):
		$Music_check.pressed = true
	else:
		$Music_check.pressed = false
	
	if(ScriptGlobal.status_som == true):
		$Som_check.pressed = true
	else:
		$Som_check.pressed = false

func _dispositivo():
	if(ScriptGlobal.dispositivo == true):
		$Aba_controles_desktop/Mult_player.visible = false
		$Aba_controles_desktop/Single_player.visible = false
		$Aba_controles_desktop/Jogador_1.visible = false
		$Aba_controles_desktop/Jogadores_2.visible = false
		$Aba_controles_desktop/Controles_mobile.visible = true
	else:
		
		$Aba_controles_desktop/Controles_mobile.visible = false
		$Aba_controles_desktop/Jogador_1.visible = true
		$Aba_controles_desktop/Jogadores_2.visible = true

func _press():
	if(ScriptGlobal.status_som == true):
		$Som_press.play()
	else:
		$Som_press.stop()


func _popup_som():
	if(ScriptGlobal.status_som == true):
		$Som_popup.play()
	else:
		$Som_popup.stop()

func _selec():
	if(ScriptGlobal.status_som == true):
		$Som_selec.play()
	else:
		$Som_selec.stop()

func _pause_som():
	if(ScriptGlobal.status_som == true):
		$Som_pause.play()
	else:
		$Som_pause.stop()

func _ready():
	$".".visible = false
	_controle_checks()
	_dispositivo()

func _process(delta):
#	Controla o pause ( A parte pause, o nó tem que estar no modo Process)
	if(Input.is_action_just_pressed("pause")):
		_pause()
	
	if(ScriptGlobal.pause_excluir == true):
		queue_free()
		
#Controlando qual padrão usar (joystick ou seta) - visual
	if(ScriptGlobal.joystick):
#		$Aba_controles_desktop/Controles_mobile/Botao_seta.modulate = Color(0.32549, 0.286275, 0.286275)
		$Aba_controles_desktop/Controles_mobile/Botao_joystick.modulate = Color(0.32549, 0.286275, 0.286275)
		$Aba_controles_desktop/Controles_mobile/Botao_seta.modulate = Color(1, 1, 1)
#		$Aba_controles_desktop/Controles_mobile/Botao_joystick.modulate = Color(1, 1, 1)
	else:
		$Aba_controles_desktop/Controles_mobile/Botao_joystick.modulate = Color(0.32549, 0.286275, 0.286275)
		$Aba_controles_desktop/Controles_mobile/Botao_seta.modulate = Color(1, 1, 1)

func _on_Controles_pressed():
	_press()
	$Aba_controles_desktop.visible = true

#_____________Controles_____________
func _on_Jogador_1_pressed():
	_press()
	$Aba_controles_desktop/Single_player.visible = true
	$Aba_controles_desktop/Mult_player.visible = false
func _on_Jogadores_2_pressed():
	_press()
	$Aba_controles_desktop/Mult_player.visible = true
	$Aba_controles_desktop/Single_player.visible = false
func _on_fechar_butt_ctrl_pressed():
	_press()
	$Aba_controles_desktop.visible = false


func _on_Voltar_jogo_pressed():
	_pause()
	

func _on_Voltar_menu_principal_pressed():
	_press()
	$Popup_sair.visible = true


func _on_Music_check_pressed():
	_press()
	if($Music_check.pressed):
		ScriptGlobal.status_music= true
	else:
		ScriptGlobal.status_music = false


func _on_Som_check_pressed():
	_press()
	if($Som_check.pressed):
		ScriptGlobal.status_som = true
	else:
		ScriptGlobal.status_som = false

#Controlando qual padrão usar (joystick ou seta) - ação
func _on_Botao_joystick_pressed():
	_press()
	ScriptGlobal.joystick = true
	
func _on_Botao_seta_pressed():
	_press()
	ScriptGlobal.joystick = false

#____ popup de ir para menu principal
func _on_No_pressed():
	_press()
	$Popup_sair.visible = false
func _on_Sim_pressed():
	_press()
	_pause()
	$Popup_sair.visible = false
	ScriptGlobal.venceu = false
	ScriptGlobal.loading_som = false
	ScriptGlobal.ctrl_timer_ranking = false
	ScriptChangeLoading.ir_para("res://Cenas/Menu/cena_menu.tscn",self)
	ScriptGlobal.pause_menu = true

#_____________ Som do mouse em cima Geral _____________
func _on_Controles_mouse_entered():
	_selec()
func _on_Voltar_jogo_mouse_entered():
	_selec()
func _on_Music_check_mouse_entered():
	_selec()
func _on_Som_check_mouse_entered():
	_selec()
func _on_Jogador_1_mouse_entered():
	_selec()
func _on_Jogadores_2_mouse_entered():
	_selec()
func _on_fechar_butt_ctrl_mouse_entered():
	_selec()
func _on_Voltar_menu_principal_mouse_entered():
	_selec()
func _on_No_mouse_entered():
	_selec()
func _on_Sim_mouse_entered():
	_selec()
func _on_Botao_joystick_mouse_entered():
	_selec()
func _on_Botao_seta_mouse_entered():
	_selec()


