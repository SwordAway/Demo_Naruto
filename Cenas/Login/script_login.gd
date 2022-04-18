extends Control

var link = "http://narutin.freevar.com/"
var link_drive = "https://drive.google.com/drive/folders/1BsZ7goOVRYCVErPY_NyNzNx-O5Csxc_X?usp=sharing"


func _press():
	if(ScriptGlobal.status_som == true):
		$Som_press.play()
	else:
		$Som_press.stop()
	

# Controla pós intro
func _intro():
	$BemVindo.visible = false
	$BemVindoDemo.visible = false
	$ContoleTelaDeBemVindo.visible = false
	$Fechar_jogo.visible = false
	$Baixar_versoes.visible = false
	$Caixinha.visible = false
	


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


# Controla o som dos checks
func _check():
	if(ScriptGlobal.status_music == false || ScriptGlobal.status_som == false):
		$Caixinha/Check_som.pressed = false
	else:
		$Caixinha/Check_som.pressed = true

		
func _ready():
	$TelaDeBemVindo.visible = true
	ScriptGlobal.loading = 1
	ScriptGlobal.loading_som = true
	if(ScriptGlobal.intro == true):
		$Timer_inicio.start()
		_intro()
	else:
		$ContoleTelaDeBemVindo.visible = false
		$BemVindo.visible = false
		$BemVindoDemo. visible = true
		$Fechar_jogo.visible = true
		$Baixar_versoes.visible = true
		$Caixinha.visible = true


func _telaBemVindo():
	$ContoleTelaDeBemVindo.visible = false
	$Fechar_jogo.visible = false
	$BemVindoDemo.visible = false
	$Baixar_versoes.visible = false
	$Caixinha.visible = false
	$BemVindo.visible = true
	$Timer.start()




func _process(delta):
	
	_check()
	$BemVindo/Nome_player.text = ScriptGlobal.player
	if(Input.is_action_just_pressed("enter")):
		_on_Logar_pressed()
	
	
#	 faz com que a intro ocorra 1 vez ao iniciar o jogo
	if(ScriptGlobal.intro == true):
		pass
	else:
		if(ScriptGlobal.intro_valida == 1):
			$ContoleTelaDeBemVindo.visible = false
			$BemVindo.visible = false
			$BemVindoDemo.visible = true
			$Fechar_jogo.visible = true
			$Baixar_versoes.visible = true
			$Caixinha.visible = true
			ScriptGlobal.intro_valida = 2
	
	
#	Controlando a musica 
	if(ScriptGlobal.status_music == true):
		$Music.stream_paused = false
		if(not $Music.playing && ScriptGlobal.loading_som == true):
			$Music.play()
		if($Music.playing && ScriptGlobal.loading_som == false):
			$Music.stop()
	else:
		$Music.stream_paused = true

#		Controle do checkbox de senha
	if($ContoleTelaDeBemVindo/Senha_visivel.pressed == true):
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_aberto.visible = false
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_fechado.visible = true
		$ContoleTelaDeBemVindo/Tx_senha.secret = true
	else:
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_aberto.visible = true
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_fechado.visible = false
		$ContoleTelaDeBemVindo/Tx_senha.secret = false

#	Controle do checkbox de som
	if($Caixinha/Check_som.pressed == true):
		$Caixinha/Check_som/Com_som.visible = true
		$Caixinha/Check_som/Sem_som.visible = false
		ScriptGlobal.status_som = true
		ScriptGlobal.status_music = true
		ScriptGlobal.checks = true
		
	else:
		$Caixinha/Check_som/Com_som.visible = false
		$Caixinha/Check_som/Sem_som.visible = true
		ScriptGlobal.status_som = false
		ScriptGlobal.status_music = false
		ScriptGlobal.checks = false
		
		
#	


# Verifica com o banco de dados os dados
func _verificacao_Login(): #importante
	var url = "http://narutin.freevar.com/consultar.php?";
	var data = "email=" + $ContoleTelaDeBemVindo/Tx_email.text + "&password=" + $ContoleTelaDeBemVindo/Tx_senha.text;
	var headers = []
	var use_ssl = false
	$HTTPRequest.request(url + data, headers, use_ssl, HTTPClient.METHOD_GET)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print ("body = " + body.get_string_from_utf8())
	var resultado = body.get_string_from_utf8()
	
	if(resultado != ""):
		ScriptGlobal.player = resultado
		_telaBemVindo()
	else: #treco de mostrar a senhor invalida (fazer ainda)
		_popup_som()
		$Popup.visible = true
		$ContoleTelaDeBemVindo/Logar.disabled = true
		$ContoleTelaDeBemVindo/Offline.disabled = true


# Quando clicar (som e ação)
func _on_LogarToutch_pressed():
	_press()
	print("identificou")
	_verificacao_Login()


# Quando clicar no botão para logar
func _on_Logar_pressed():
	_press()
	_verificacao_Login()

# Quando o tempo acabar
func _on_Timer_timeout():
	ScriptGlobal.loading_som = false
	ScriptChangeLoading.ir_para("res://Cenas/Menu/cena_menu.tscn", self)
	

# Quando clicar no botão para jogar offline
func _on_Offline_pressed():
	_press()
	$Fechar_jogo.visible = false
	ScriptGlobal.player = "Ninja"
	_telaBemVindo()
	


# Controlar se a senha fica visivel 
func _on_Senha_visivel_pressed():
	_press()
	if($ContoleTelaDeBemVindo/Senha_visivel.pressed == true):
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_aberto.visible = false
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_fechado.visible = true
		$ContoleTelaDeBemVindo/Tx_senha.secret = true
	else:
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_aberto.visible = true
		$ContoleTelaDeBemVindo/Senha_visivel/Olho_fechado.visible = false
		$ContoleTelaDeBemVindo/Tx_senha.secret = false


# Quando clicar para fazer o cadastro
func _on_SiteCadastro_pressed():
	_press()
	OS.shell_open("http://narutin.freevar.com/")


#  -----Sons de mouse passando por cima-------
func _on_SiteCadastro_mouse_entered():
	_selec()
func _on_Logar_mouse_entered():
	_selec()
func _on_Fechar_popup_mouse_entered():
	_selec()
func _on_Offline_mouse_entered():
	_selec()
func _on_JOGAR_mouse_entered():
	_selec()
func _on_Baixar_versoes_mouse_entered():
	_selec()
func _on_Fechar_jogo_mouse_entered():
	_selec()
func _on_Fazer_conta_mouse_entered():
	_selec()


# Fechar popup
func _on_Fechar_popup_pressed():
	_press()
	$Popup.visible = false
	_popup_som()
	$ContoleTelaDeBemVindo/Logar.disabled = false
	$ContoleTelaDeBemVindo/Offline.disabled = false




# Controla o som da tela de inicio pelo icone
func _on_Check_som_pressed():
	_press()
	if($Caixinha/Check_som.pressed == true):
		$Caixinha/Check_som/Com_som.visible = true
		$Caixinha/Check_som/Sem_som.visible = false
		ScriptGlobal.status_som = true
		ScriptGlobal.status_music = true
		ScriptGlobal.checks = true
		
	else:
		$Caixinha/Check_som/Com_som.visible = false
		$Caixinha/Check_som/Sem_som.visible = true
		ScriptGlobal.status_som = false
		ScriptGlobal.status_music = false
		ScriptGlobal.checks = false

# Identifica se é um celular
func _on_Dipositivo_pressed():
	ScriptGlobal.dispositivo = true
	


func _on_JOGAR_pressed():
	_press()
	_telaBemVindo()
	ScriptGlobal.player = "Ninja"


# Ir para tela de login
func _on_Fazer_conta_pressed():
	_press()
	$ContoleTelaDeBemVindo.visible = true
	$BemVindoDemo.visible = false
	

# Baixar outras versões
func _on_Baixar_versoes_pressed():
	_press()
	OS.shell_open(link_drive)

# Fechar o jogo
func _on_Fechar_jogo_pressed():
	_press()
	get_tree().quit()
	

func _on_Timer_inicio_timeout():
	ScriptGlobal.intro = false
	
