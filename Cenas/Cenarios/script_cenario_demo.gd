extends Node2D

onready var cena_inimigo = preload("res://Cenas/Inimigos/Ninja_range.tscn")
# Jeito 1
var lista = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

#--------------------
#Jeito 2
#var lista = {}
#--------------------

var inimigo



func _ready():
	randomize()
#	Na internet não tem nada sobre a godot, leia a documentação da própria godot lá tem tudo.
#--------------------
#	Jeito 2
#	lista = range(31)
#	lista.remove(0)
#--------------------

#	 A cada spawn do inimigo, excluir o numero selecionado do array
	for i in 24:
		lista.shuffle() # randomiza os dados do array
		var posicao_spawn = get_node("Lista/" + str(lista.front())) # complementa com o numero aleátorio objtido 
		inimigo = cena_inimigo.instance()
		inimigo.position = posicao_spawn.position # Pega a posição e passa nó onde deve nascer
#		get_node("Lista/" + str(lista.front())).call_deferred("add_child",inimigo) #spawn como filho desses Positions2D no mapa
		get_tree().root.call_deferred("add_child",inimigo)# spawn tendo como referencia a posicao dos Positions2D no mapa
		lista.remove(0) # remove o primeiro index do array
		
	ScriptGlobal.pause_menu = false
	ScriptGlobal.morte_vitoria = false
	ScriptGlobal.ctrl_timer_ranking = true



func _process(delta):
	
#	Deixando a cena invisivel antes de exclui-lá pós carregamento
	if(ScriptGlobal.pause_menu || ScriptGlobal.morte_vitoria):
		$Cenario2.visible = false
		$HUD/Control.visible = false
		$Control_interface/Control.visible = false
		
#	Excluindo pós carregamento da prox cena (atribuir true para variavel no ready da prox cena)
	if(ScriptGlobal.cenario_excluir):
		queue_free()

