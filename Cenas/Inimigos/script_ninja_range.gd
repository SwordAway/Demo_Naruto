extends KinematicBody2D

#-48000 força pulo = -800
export var forca_do_pulo = -40000
export var gravidade = 2000
var movimento = Vector2.ZERO


#____ Morte / levar muito dano____
export var vel_mov_queda = 100
var movimento_queda = Vector2(vel_mov_queda,-1)


onready var identif_player = ScriptGlobal.get("identif_player")
onready var barra_vida = get_node("Barra_vida")

var foice_cena = preload("res://Cenas/Habilidades/cena_foice.tscn")

export var normal = true
export var pulo = false
export var ataque = false
export var sofrer_dano = false
export var morte = false
export var pos_pulo = false

var controle_lado = false
var vida_inimigo = 8
var distancia

# Vida do inimigo
func _HUD():
	barra_vida.value = vida_inimigo
	
	if(vida_inimigo >=7): # Verde
		barra_vida.set_tint_progress(Color(0, 0.729412, 0.035294))
		barra_vida.set_tint_under(Color(0, 0.729412, 0.035294))
	if(vida_inimigo <=6): # Verde amarelado
		barra_vida.set_tint_progress(Color(0.592157, 0.729412, 0.035294))
		barra_vida.set_tint_under(Color(0.592157, 0.729412, 0.035294))
	if(vida_inimigo <=4): # Laranja avermelhado
		barra_vida.set_tint_progress(Color(0.898039, 0.380392, 0.035294))
		barra_vida.set_tint_under(Color(0.898039, 0.380392, 0.035294))
	if(vida_inimigo <=2):# Vermelho
		barra_vida.set_tint_progress(Color(0.898039, 0, 0.035294))
		barra_vida.set_tint_under(Color(0.898039, 0, 0.035294))


# função de pulo
func _pulo(delta):
	$Anima.play("pulando")
	movimento.y = forca_do_pulo * delta 

# Função instanciar o inimigo
func _foice():
	var foice = foice_cena.instance()
	foice.global_position = $Posit_foice.global_position
	if(controle_lado == true):
		foice.scale.x = -1
	get_tree().root.add_child(foice)
	if(ScriptGlobal.status_som):
		$Som_lanca_foice.play()


func _HUD_animacao():
	$Anima_vida.play("visivel_on")

# Animações
func _animacao(delta):
	if(normal):
		
		if($Identif_atk_player.overlaps_body(identif_player)):
			$Anima.play("atk_foice")
			
		elif(vida_inimigo  <= 0):
			$Anima.play("morte")
			ScriptGlobal.inimigos += 1
			ScriptGlobal.furia +=10
			
		elif(not $Raycast_chao.is_colliding()):
			$Anima.play("caindo")
#
		elif($Raycast_chao.is_colliding()):
			$Anima.play("parado")
#			
		pass
	elif(pulo):
		if($Raycast_chao.is_colliding()):
			_pulo(delta)
		
	elif(pos_pulo):
		if($Raycast_chao.is_colliding()):
			$Anima.play("pos_pulo")
		pass
	elif(ataque):
		pass
	elif(sofrer_dano):
		pass
	elif(morte):
		pass


func _ready():
	$Barra_vida.visible = false



# Função process
func _physics_process(delta):
	
	if(ScriptGlobal.pause_menu || ScriptGlobal.morte_vitoria):
		queue_free()
	
	_HUD()
	if(not $Raycast_chao.is_colliding()):
		movimento.y += gravidade * delta
	movimento = move_and_slide(movimento)
	
#	Durante a animação de morte faz o movimento de queda
	if($Anima.current_animation == "morte"):
		if(controle_lado == true):
			translate(movimento_queda * delta )
			if($Img_inimigo.frame == 5):
				movimento_queda.x = 0
		else:
			translate(movimento_queda * delta * -1)
			if($Img_inimigo.frame == 5):
				movimento_queda.x = 0
	
#	 Concertando bug de quando saisse do jogo pelo pause, dava erro porque o "identif_player" perdia a referencia do player porque era excluido
	if(not ScriptGlobal.pause_menu && not ScriptGlobal.morte_vitoria):
		if(identif_player && not morte):
			distancia = identif_player.global_position.x - self.position.x
			controle_lado = true if distancia < 0 else false	
	else:
		ScriptGlobal.set("identif_player", self)
	
#	Flip do personagem (o jeito conhecido usando o scale.x estava bugando quando iria para a direita)
	if(controle_lado):
		$Img_inimigo.flip_h = false
		$Posit_foice.position.x = -16
		$Posit_foice.position.y = 8
	else:
		$Img_inimigo.flip_h = true
		$Posit_foice.position.x = 16
		$Posit_foice.position.y = 8
	
	_animacao(delta)


# Vai pular se idendificar um objeto
func _on_Identif_object_area_entered(area):
# Nivel de dificuldade Dificil
	if(ScriptGlobal.dificuldade == 3):
		if(area.name == "Clone" || area.name == "Shuriken" || area.name == "Bola_fogo"):
			if($Raycast_chao.is_colliding()):
				pulo = true
				normal = false


# Se atacar por cima
func _on_Recebe_dano_cima_area_entered(area):
	if(area.name == "Chute_atk_alto_baixo"):
		$Anima.play("morte_cima")
		vida_inimigo -= 8
		$Anima_vida.play("visivel_on")
		ScriptGlobal.inimigos += 1
		ScriptGlobal.furia +=10
		$Time_pos_morte.start()

# Quando o personagem sai da area, o inimigo volta ao normal
func _on_Identif_atk_player_body_exited(body):
	if(not morte && not sofrer_dano):
		$Anima.play("parado")

# Tempo para excluir o nó do mapa
func _on_Time_pos_morte_timeout():
	$Anima.play("fumaca_pos_morte")
	if(ScriptGlobal.status_som):
		$Som_morte_fumaca.play()


func _on_Anima_animation_finished(anim_name):
	if(anim_name == "fumaca_pos_morte"):
		queue_free()
	if(anim_name == "morte"):
		$Time_pos_morte.start()

# Receber dano, habilidades e socos
func _on_Recebe_dano_area_entered(area):
	if(area.name == "Shuriken" || area.name == "Soco" || area.name == "Bola_fogo" || area.name == "Socos_chutes"):
		vida_inimigo -= 1
		$Anima.play("sofer_dano")

# Nivel de dificuldade médio
func _on_Identif_atk_player_area_entered(area):
	if(ScriptGlobal.dificuldade == 2):
		if(area.name == "Clone"):
			$Anima.play("atk_foice_no_clone")

