extends Control

	
func _dispositivo_on():
	if(ScriptGlobal.dispositivo == true):
		$Selec_modo_jogo/Multiplayer.visible = false
		$Selec_modo_jogo/Single_player.visible = false
		$Selec_modo_jogo/Single_player2.visible = true
		$Aba_controles_desktop/Mult_player.visible = false
		$Aba_controles_desktop/Single_player.visible = false
		$Aba_controles_desktop/Controles_mobile.visible = true
		$Aba_controles_desktop/Jogador_1.visible = false
		$Aba_controles_desktop/Jogadores_2.visible = false
	else:
		$Aba_controles_desktop/Controles_mobile.visible = false
		$Selec_modo_jogo/Single_player2.visible = false
		$Selec_modo_jogo/Multiplayer.visible = true
		$Selec_modo_jogo/Single_player.visible = true
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
	


#_____________ controlando inicio da cena _____________
func _ready():
	if(ScriptGlobal.aviso == true):
		$Avisos.visible = true
	ScriptGlobal.cenario_excluir = true
	ScriptGlobal.loading = 1
	ScriptGlobal.loading_som = true
	$Menu_inicial.visible = true
	$Selec_modo_jogo.visible = false
	$Selec_personagem.visible = false
	$Configuracao.visible = false
	$Selec_personagem/Sasuke_on.visible = false
	$Selec_personagem/Naruto_on.visible = false
	
#_____________ controlando checkbox das config _____________
	if(ScriptGlobal.status_music == true):
		$Configuracao/Music_check.pressed = true
	else:
		$Configuracao/Music_check.pressed = false
	
	if(ScriptGlobal.status_som == true):
		$Configuracao/Som_check.pressed = true
	else:
		$Configuracao/Som_check.pressed = false
	_dispositivo_on()
	


func _process(delta):

# Controlando a dificuldade - Visual
	
	if(ScriptGlobal.dificuldade == 1):
		$Selec_personagem/Dificuldade_dificil.pressed = false
		$Selec_personagem/Dificuldade_dificil.modulate = Color(0.32549, 0.286275, 0.286275)
		$Selec_personagem/Dificuldade_media.pressed = false
		$Selec_personagem/Dificuldade_media.modulate = Color(0.32549, 0.286275, 0.286275)
		$Selec_personagem/Dificuldade_facil.pressed = true
		$Selec_personagem/Dificuldade_facil.modulate = Color(1, 1, 1)
		
	if(ScriptGlobal.dificuldade == 2):
		$Selec_personagem/Dificuldade_facil.pressed = false
		$Selec_personagem/Dificuldade_facil.modulate = Color(0.32549, 0.286275, 0.286275)
		$Selec_personagem/Dificuldade_dificil.pressed = false
		$Selec_personagem/Dificuldade_dificil.modulate = Color(0.32549, 0.286275, 0.286275)
		$Selec_personagem/Dificuldade_media.pressed = true
		$Selec_personagem/Dificuldade_media.modulate = Color(1, 1, 1)
		

	if(ScriptGlobal.dificuldade == 3):
		$Selec_personagem/Dificuldade_facil.pressed = false
		$Selec_personagem/Dificuldade_facil.modulate = Color(0.32549, 0.286275, 0.286275)
		$Selec_personagem/Dificuldade_media.pressed = false
		$Selec_personagem/Dificuldade_media.modulate = Color(0.32549, 0.286275, 0.286275)
		$Selec_personagem/Dificuldade_dificil.pressed = true
		$Selec_personagem/Dificuldade_dificil.modulate = Color(1, 1, 1)
		

#Controlando qual padrão usar (joystick ou seta) - visual
	if(ScriptGlobal.joystick):
#		$Aba_controles_desktop/Controles_mobile/Botao_seta.modulate = Color(0.32549, 0.286275, 0.286275)
		$Aba_controles_desktop/Controles_mobile/Botao_joystick.modulate = Color(0.32549, 0.286275, 0.286275)
		$Aba_controles_desktop/Controles_mobile/Botao_seta.modulate = Color(1, 1, 1)
#		$Aba_controles_desktop/Controles_mobile/Botao_joystick.modulate = Color(1, 1, 1)
	else:
		$Aba_controles_desktop/Controles_mobile/Botao_joystick.modulate = Color(0.32549, 0.286275, 0.286275)
		$Aba_controles_desktop/Controles_mobile/Botao_seta.modulate = Color(1, 1, 1)

#_____________ Musica _____________
	
#_____________ Secundária ____________
	if($Selec_personagem.visible == true):
		$Music.stop()
		if(ScriptGlobal.status_music == true):
			$Music2.stream_paused = false
			if(not $Music2.playing && ScriptGlobal.loading_som == true):
				$Music2.play()
			if($Music2.playing && ScriptGlobal.loading_som == false):
				$Music2.stop()
		else: 
			$Music2.stream_paused = true
	else:
		$Music2.stop()
		
#_____________ Principal ____________
		if(ScriptGlobal.status_music == true):
			$Music.stream_paused = false
			if(not $Music.playing && ScriptGlobal.loading_som == true):
				$Music.play()
			if($Music.playing && ScriptGlobal.loading_som == false):
				$Music.stop()
		else:
			$Music.stream_paused = true
	




#_____________ Som do mouse em cima Geral _____________
func _on_Sair_mouse_entered():
	_selec()
func _on_Voltar_mouse_entered():
	 _selec()
func _on_Fechar_popup_mult_mouse_entered():
	_selec()
func _on_Single_player_mouse_entered():
	_selec()
func _on_Single_player2_mouse_entered():
	_selec()
func _on_Multiplayer_mouse_entered():
	_selec()
func _on_Voltar_modo_jogo_mouse_entered():
	_selec()
func _on_Ranking_mouse_entered():
	_selec()
func _on_Fechar_ranking_mouse_entered():
	_selec()
func _on_Configuracoes_mouse_entered():
	_selec()
func _on_Jogador_1_mouse_entered():
	_selec()
func _on_Jogadores_2_mouse_entered():
	_selec()
func _on_Voltar_menu_mouse_entered():
	_selec()
func _on_Controles_mouse_entered():
	_selec()	
func _on_Som_check_mouse_entered():
	_selec()
func _on_Music_check_mouse_entered():
	_selec()
func _on_fechar_butt_ctrl_mouse_entered():
	_selec()
func _on_No_mouse_entered():
	_selec()
func _on_Sim_mouse_entered():
	_selec()
func _on_Fechar_creditos_mouse_entered():
	_selec()
func _on_Github_mouse_entered():
	_selec()
func _on_Creditos_mouse_entered():
	_selec()
func _on_Jogar_mouse_entered():
	_selec()
func _on_Dificuldade_facil_mouse_entered():
	_selec()
func _on_Dificuldade_dificil_mouse_entered():
	_selec()
func _on_Dificuldade_media_mouse_entered():
	_selec()
func _on_Ok_mouse_entered():
	_selec()
func _on_Botao_joystick_mouse_entered():
	_selec()
func _on_Botao_seta_mouse_entered():
	_selec()


#_____________ Menu Principal _____________
func _on_Jogar_pressed():
	_press()
	$Menu_inicial.visible = false
	$Selec_modo_jogo.visible = true
	
func _on_Ranking_pressed():
	_press()
	$Aba_ranking.visible = true
	_popup_som()
func _on_Configuracoes_pressed():
	_press()
	$Menu_inicial.visible = false
	$Configuracao.visible = true
func _on_Creditos_pressed():
	_press()
	$Aba_creditos.visible = true
func _on_Sair_pressed():
	_press()
	$Popup_sair.visible = true
	_popup_som()


#_____________Confirmação para sair tela inicial_____________
func _on_Sim_pressed():
	_press()
	ScriptChangeLoading.ir_para("res://Cenas/Login/cena_login.tscn",self)
	ScriptGlobal.loading_som = false
	
func _on_No_pressed():
	_press()
	$Popup_sair.visible = false
	_popup_som()


#_____________ Seleção modo de jogo - Menu_____________
func _on_Voltar_pressed():
	_press()
	$Selec_modo_jogo.visible = false
	$Menu_inicial.visible = true


#_____________ Single player desktop e Mobile_____________
func _on_Single_player_pressed():
	_press()
	$Selec_personagem.visible = true
	
func _on_Single_player2_pressed():
	_press()
	$Selec_personagem.visible = true


#_____________ Multiplayer_____________
func _on_Multiplayer_pressed():
	_press()
	$Popup_coming_mult.visible = true
	_popup_som()
func _on_Fechar_popup_mult_pressed():
	_press()
	$Popup_coming_mult.visible = false
	_popup_som()


#_____________ Seleção de personagem_____________
func _on_Voltar_modo_jogo_pressed():
	_press()
	$Selec_personagem.visible = false
	
func _on_Naruto_pressed():
	_press()
	ScriptGlobal._reset()
	ScriptGlobal.cenario_excluir = false
	ScriptGlobal.personagem = 1
	ScriptChangeLoading.ir_para("res://Cenas/Cenarios/cena_cenario_demo.tscn",self)
	ScriptGlobal.loading_som = false
	
func _on_Sasuke_pressed():
	_press()
	ScriptGlobal._reset()
	ScriptGlobal.cenario_excluir = false
	ScriptGlobal.personagem = 2
	ScriptChangeLoading.ir_para("res://Cenas/Cenarios/cena_cenario_demo.tscn",self)
	ScriptGlobal.loading_som = false
	
func _on_Naruto_mouse_entered():
	_selec()
	$Selec_personagem/Naruto_on.visible = true
	$Selec_personagem/Sasuke_on.visible = false
	
func _on_Sasuke_mouse_entered():
	_selec()
	$Selec_personagem/Sasuke_on.visible = true
	$Selec_personagem/Naruto_on.visible = false
	
# Controlando a dificuldade - ação
func _on_Dificuldade_facil_pressed():
	_press()
	if($Selec_personagem/Dificuldade_facil.pressed):
		ScriptGlobal.dificuldade = 1
	
# Controlando a dificuldade - ação
func _on_Dificuldade_media_pressed():
	_press()
	if($Selec_personagem/Dificuldade_media.pressed):
		ScriptGlobal.dificuldade = 2
	
# Controlando a dificuldade - ação
func _on_Dificuldade_dificil_pressed():
	_press()
	if($Selec_personagem/Dificuldade_dificil.pressed):
		ScriptGlobal.dificuldade = 3


#_____________ Ranking_____________
func _on_Fechar_ranking_pressed():
	_press()
	$Aba_ranking.visible = false
	_popup_som()

#_____________Configurações_____________
func _on_Som_check_pressed():
	_press()
	if($Configuracao/Som_check.pressed):
		ScriptGlobal.status_som = true
	else:
		ScriptGlobal.status_som = false
	
func _on_Music_check_pressed():
	_press()
	if($Configuracao/Music_check.pressed):
		ScriptGlobal.status_music= true
	else:
		ScriptGlobal.status_music = false
	
func _on_Controles_pressed():
	_press()
	$Aba_controles_desktop.visible = true
	
func _on_Voltar_menu_pressed():
	_press()
	$Configuracao.visible = false
	$Menu_inicial.visible = true


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
	
#Controlando qual padrão usar (joystick ou seta) - ação
func _on_Botao_joystick_pressed():
	_press()
	ScriptGlobal.joystick = true
	
func _on_Botao_seta_pressed():
	_press()
	ScriptGlobal.joystick = false
	

#_____________Créditos_____________
func _on_Fechar_creditos_pressed():
	_press()
	$Aba_creditos.visible = false
	
func _on_Github_pressed():
	_press()
	OS.shell_open("https://bagy.bio/swordaway")


# ___________ Fechar jogo ____________
func _on_Fechar_jogo_pressed():
	_press()
	get_tree().quit()
	
# ___________ Avisos ____________
func _on_Ok_pressed():
	_press()
	$Avisos.visible = false
	ScriptGlobal.aviso = false
