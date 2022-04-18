extends KinematicBody2D

#12000 vel movimento - andando = 200
#24000 vel movimento - correndo = 400
export var velocidade_de_movimento = 12000
#-48000 força pulo = -800
export var forca_do_pulo = -48000
export var gravidade = 2000
var movimento = Vector2(0,-1)


#____ Morte / levar muito dano____
export var vel_mov_queda = 100
var movimento_queda = Vector2(vel_mov_queda,-1)


var run = false
var agaixar = false
var parede = false
var atk_baixo = true


# ____ Carregando as cenas das habilidades ____
var shuriken = preload("res://Cenas/Habilidades/cena_shuriken.tscn")
var ataque_clone = preload("res://Cenas/Habilidades/cena_jutsu_clone.tscn")
var jutsu_B_fogo = preload("res://Cenas/Habilidades/cena_bola_de_fogo.tscn")


export var cont_dano = 0
export var normal = true
export var ataque = false
export var jutsu = false
export var sofrer_dano = false
export var morrer = false
export var atk1 = false
export var atk2 = false
export var atk3 = false
export var vitoria = false
export var bola_de_fogo = false
var pode_pular = false


onready var som_socos = get_parent().get_node("Som_socos")
onready var som_jutsu_clone = get_parent().get_node("Som_jutsu_clone")
onready var som_jutsu_clone_aparecendo = get_parent().get_node("Som_jutsu_clone_aparecendo")
onready var som_lanca_shuriken = get_parent().get_node("Som_lanca_shuriken")
onready var sasuke_node = get_parent().get_node("Sasuke")
onready var tempo_pulo = $Tempo_pulo as Timer
onready var musica = get_parent().get_node("Music")
onready var camera = $Camera
var direcao_movimento = 0
var controle_lado = true



#____ pré definições ____
func _setup():
	ScriptGlobal.loading_som = true
	velocidade_de_movimento = 12000
	forca_do_pulo = -48000
	vel_mov_queda = 100
	gravidade = 2000
	run = false
	agaixar = false
	parede = false
	atk_baixo = true
	cont_dano = 0
	normal = true
	ataque = false
	jutsu = false
	sofrer_dano = false
	morrer = false
	atk1 = false
	atk2 = false
	atk3 = false
	vitoria = false
	bola_de_fogo = false
	pode_pular = false
	direcao_movimento = 0
	controle_lado = true


# ________ Instancia o jutsu bola de fogo _____
func _jutsu_bola_fogo():
	var bola_fogo = jutsu_B_fogo.instance()
	bola_fogo.global_position = $Posit_bola_fogo.global_position
	bola_fogo.z_index = -1
	if(controle_lado == false):
		bola_fogo.scale.x = -1
	get_tree().root.add_child(bola_fogo)



func _shuriken():
	var shurike = shuriken.instance()
	shurike.global_position = $Posit_shuriken.global_position
	shurike.z_index = -1
	if(controle_lado == false):
		shurike.scale.x = -1
	get_tree().root.add_child(shurike)

func _clone():
	var clone = ataque_clone.instance()
	clone.global_position = $Posit_clone.global_position
	clone.z_index = -1
	if(controle_lado == false):
		clone.scale.x = -1
	get_tree().root.add_child(clone)

# Sons colocados pelo animationPlayer - instanciando eles na animação (Add Track > call method > nó onde ta o script com a função
func _som_socos():
	if(ScriptGlobal.status_som):
		som_socos.play()

func _som_jutsu_clone():
	if(ScriptGlobal.status_som):
		som_jutsu_clone.play()

func _som_jutsu_clone_aparecendo():
	if(ScriptGlobal.status_som):
		som_jutsu_clone_aparecendo.play()

func _som_lanca_shuriken():
	if(ScriptGlobal.status_som):
		som_lanca_shuriken.play()


# ___ controla a musica da fase ____
func _music():
	if(ScriptGlobal.status_music == true):
		musica.stream_paused = false
		if(not musica.playing && ScriptGlobal.loading_som == true):
			musica.play()
		if(musica.playing && ScriptGlobal.loading_som == false):
			musica.stop()
	else:
		musica.stream_paused = true


func _ready():
	
	_setup()
	if(ScriptGlobal.personagem != 2):
		queue_free()
	if(ScriptGlobal.personagem == 2):
		ScriptGlobal.set("identif_player", self)
		$Camera.current = true



#____ Processa tudo - Jogue as funções aqui pra funcionar (aquelas que criou sozinho por código) ____
func _physics_process(delta):

	if(ScriptGlobal.pause_menu):
		queue_free()
	_music()
	_animacoes(delta)
	
#	--- Limitando na tela de jogo
	global_position.x = clamp(global_position.x,10,2550)
#	--- Morte do jogador por limite chão
	if(global_position.y > camera.limit_bottom):
		ScriptGlobal.ctrl_timer_ranking = false
		ScriptGlobal.loading = 2
		ScriptGlobal.loading_som = false
		ScriptChangeLoading.ir_para("res://Cenas/Game_over/cena_game_over.tscn", self)
		ScriptGlobal.morte_vitoria = true
##		position.y = 0
##		position.x = 0
		
	if(jutsu):
		movimento.y = 0
	else:
		movimento.y += gravidade * delta
		
#		_____________ Pra não se movimentar_____________
	if(not sofrer_dano && not morrer && not vitoria):
		if(ScriptGlobal.joystick && ScriptGlobal.dispositivo):
			direcao_movimento = ScriptGlobal.mov_joystick
		else:
			direcao_movimento = int(Input.is_action_pressed("direita")) - int(Input.is_action_pressed("esquerda"))
	movimento.x = velocidade_de_movimento * direcao_movimento * delta
		
	if(direcao_movimento > 0):
		if(controle_lado == false):
			scale.x = scale.x * -1
		controle_lado = true
	elif(direcao_movimento < 0):
		if(controle_lado == true):
			scale.x = scale.x * -1
		controle_lado = false
		
#		__________ Pra não se movimentar_____________
	if(not sofrer_dano && not morrer):
#		__________ Pulo pelo chão - usando Coiote timer_____________
		if(Input.is_action_just_pressed("cima") && pode_pular):
			movimento.y = forca_do_pulo * delta
	if(is_on_floor()):
		pode_pular = true
	elif(pode_pular && tempo_pulo.is_stopped()):
		tempo_pulo.start()
		
	if(Input.is_action_just_pressed("descer_plataforma")):
		sasuke_node.set_collision_mask_bit(10, false)
	elif(Input.is_action_just_released("descer_plataforma")):
		sasuke_node.set_collision_mask_bit(10, true)
		
	movimento = move_and_slide(movimento, Vector2(0,-1))


func _animacoes(delta):
#	_____________ Controlando o pulso/empurrão da morte e levar mt dano_____________
	if($Anima.current_animation == "levantar" || $Anima.current_animation == "morte"):
		if($Img_sasuke.frame == 0):
			movimento_queda.x = 100
		if(controle_lado == true):
			translate(movimento_queda * delta * -1)
			if($Img_sasuke.frame == 3):
				movimento_queda.x = 0
		else:
			translate(movimento_queda * delta )
			if($Img_sasuke.frame == 3):
				movimento_queda.x = 0
			
#_____________ Animações normais/principais_____________
	if(normal):
#_____________ Controlando a corrida - ativo _____________
		
		if(ScriptGlobal.dispositivo == false):
			if(Input.is_action_pressed("correr")):
				run = true
			else:
				run = false
			
		if(Input.is_action_just_pressed("correr_mobile") && ScriptGlobal.run == false ):
			ScriptGlobal.run = true
			run = true
		elif(Input.is_action_just_pressed("correr_mobile") && ScriptGlobal.run == true):
			ScriptGlobal.run = false
			run = false
			
			pass
		
#_____________ Animação no chão_____________
		if(is_on_floor() && direcao_movimento):
#_____________ Controlando a corrida - animação _____________
			if(run && is_on_floor()):
				$Anima.play("correndo")
			else:
				$Anima.play("andando")
			
#______________ Grudar na parede _____________
		if($Raycast_parede.is_colliding() && is_on_wall() && not is_on_floor()):
			$Anima.play("parede")
#__________ Outra etapa para corrigir o bug da animação (total 2 preventivas) __________
			if($Raycast_parede.is_colliding() && is_on_wall() && $Anima.current_animation == "parede"):
				gravidade = 0
				movimento.y = 0
				parede = true
			
#_____________ Agaixando - Seta pra baixo _____________
		if(is_on_floor() && Input.is_action_pressed("baixo")):
			$Anima.play("agaixar")
			velocidade_de_movimento = 0
			forca_do_pulo = 0
			agaixar = true
			
		elif(not is_on_floor() && Input.is_action_just_pressed("baixo")):
			$Anima.play("atk_alto_baixo")
			movimento.y  = -forca_do_pulo/2 * delta 
			
#_____________ Defendendo - letra D _____________
		elif(Input.is_action_pressed("defender")):
			$Anima.play("defender")
			if(is_on_floor()):
				velocidade_de_movimento = 0
			
#_____________ condição de vitória _____________
		elif(ScriptGlobal.inimigos > 20):
			ScriptGlobal.ctrl_timer_ranking = false
			$Anima.play("vitoria")
			
		elif(not is_on_floor() && not is_on_wall() && not $Anima.current_animation == "pulo_parede"):
			$Anima.play("caindo")
			
		elif(is_on_floor() && direcao_movimento == 0 && not $Anima.current_animation == "sofrer_dano" ):
			$Anima.play("parado")
			
#_____________ Pulo - seta pra cima _____________
		if(Input.is_action_just_pressed("cima") && pode_pular):
			$Anima.play("pulando")
			
		elif(Input.is_action_pressed("combo_single")):
			$Anima.play("golpe_1")
			if(is_on_floor()):
				velocidade_de_movimento = 0
				forca_do_pulo = 0
				
#_____________ Jutsu Clone - tecla Q _____________
		if(Input.is_action_just_pressed("jutsu1_single") && jutsu == false):
			$Anima.play("jutsu_clone")
			$Fumaca.play("fumaça")
			jutsu = true

			
#____________ Jutsu indefinido - tecla W_____________
		elif(Input.is_action_just_pressed("jutsu2_single")):
				pass
			
#____________ Jutsu bola de fogo - tecla E _____________
		elif(Input.is_action_just_pressed("jutsu3_single")):
				$Anima.play("jutsu_bola_fogo")
				movimento.y = 0
			
#____________ Jutsu indefinido - tecla R _____________
		elif(Input.is_action_just_pressed("jutsu4_single")):
				pass
			
#____________ Shuriken - tecla S _____________
		elif(Input.is_action_just_pressed("shuriken_single")):
			$Anima.play("atk_shuriken")
			
		
		
#_____________ Controlar as animações de ataque____________
	elif(ataque):
		if(is_on_floor() && atk_baixo):
				velocidade_de_movimento = 0
			
#_____________ Sequência de socos (maior parte pelo animation player)____________
		if(atk1):
			if(Input.is_action_pressed("combo_single")):
				$Anima.play("golpe_2")
				if(is_on_floor()):
					velocidade_de_movimento = 0
					forca_do_pulo = 0
			if(atk2):
				if(Input.is_action_pressed("combo_single")):
					$Anima.play("golpe_3")
					if(is_on_floor()):
						velocidade_de_movimento = 0
						forca_do_pulo = 0
				if(atk3):
					pass
		
	elif(jutsu):
		if(bola_de_fogo):
			$Anima.play("jutsu_bola_fogo_com_fogo")
			_jutsu_bola_fogo()
		pass
		
#_____________ controlando animações - iniciando após o Area Recebe_dano_____________
	if(sofrer_dano):
		if(cont_dano<=5):
			$Anima.play("sofer_dano")
		if(cont_dano > 5 ):
			$Anima.play("levantar")
		if(ScriptGlobal.vida <= 0):
			ScriptGlobal.ctrl_timer_ranking = false
			$Anima.play("morte")
		
		pass
	if(morrer):
		pass
	
	if(vitoria):
		pass
	
	elif(agaixar):
		if(Input.is_action_just_released("baixo")):
			agaixar = false
			normal = true
		
	elif(parede):
		
#_____ correção de bug - ele permanece com a animação "parede" e fica parado no ar,
#	 causado quando se faz mt rapido a ação de escalar _________
		if(not $Raycast_parede.is_colliding() && not $Anima.current_animation == "parede"):
			parede = false
			normal = true
			gravidade = 2000
#_____________ Controla o pulo de acordo com o lado oposto____________
		elif(Input.is_action_pressed("esquerda")):
			if($Raycast_parede.is_colliding() && controle_lado == true and not is_on_floor()):
				$Anima.play("pulo_parede")
				movimento.y = forca_do_pulo * delta
				parede = false
				normal = true
				gravidade = 2000
				
		elif(Input.is_action_pressed("direita")):
			if($Raycast_parede.is_colliding() && controle_lado == false && not is_on_floor()):
				$Anima.play("pulo_parede")
				movimento.y = forca_do_pulo * delta
				parede = false
				normal = true
				gravidade = 2000
#_____________ sair da parede - seta pra baixo _________ (ambiente futuro ideia(lvls) - naruto domina o chakra pra ficar grudado)
		elif($Raycast_parede.is_colliding() && Input.is_action_just_pressed("baixo")):
			$Raycast_parede.enabled = false
			parede = false
			normal = true
			gravidade = 2000



# _____ Quando um objeto acerta _____
func _on_Recebe_dano_area_entered(area):
	if(area):
		sofrer_dano = true
		cont_dano += 1
		ScriptGlobal.vida -= 5


func _on_Anima_animation_finished(anim_name):
	if(anim_name == "vitoria" || "morte"):
		$Tempo_win_lose.start()

func _on_Tempo_win_lose_timeout():
	if(morrer):
		ScriptGlobal.morte_vitoria = true
		ScriptGlobal.loading = 2
		ScriptGlobal.loading_som = false
		ScriptChangeLoading.ir_para("res://Cenas/Game_over/cena_game_over.tscn",self)
	
	if(vitoria):
		ScriptGlobal.morte_vitoria = true
		ScriptGlobal.loading = 2
		ScriptGlobal.loading_som = false
		ScriptChangeLoading.ir_para("res://Cenas/Vitoria/cena_vitoria.tscn", self)
	
func _on_Tempo_pulo_timeout():
	pode_pular = false
