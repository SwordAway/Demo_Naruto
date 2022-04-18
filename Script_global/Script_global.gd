extends Node


var player = ""
var status_som = true
var status_music = true
var checks = true
var dispositivo = false
var personagem = 0
var intro = true
var intro_valida = 1
var inimigos = 0
var vida = 100
var furia = 0
var loading = 0
var loading_som = true
var pause_menu = false
var morte_vitoria = false
var pause_excluir = false
var run = false
var cenario_excluir = false
var timer_ranking = 0
var ctrl_timer_ranking = false
var ver_ranking = false
var venceu = false
var identif_player 
var dificuldade = 1
var joystick = false
var mov_joystick = Vector2(0,0)
var aviso = true


func _reset():
	furia = 0
	vida = 100
	inimigos = 0
	pause_menu = false
	pause_excluir = false
	morte_vitoria = false
	timer_ranking = 0
	ctrl_timer_ranking = true
	ver_ranking = true
	run = false


func _process(delta):
	
	if(vida >= 100):
		vida = 100
	if(vida <= 0):
		vida = 0
	if(furia >= 20):
		furia = 20

