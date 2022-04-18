extends Node




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



export var max_tempo_carregamento = 100000

# Usar a função para mudar de cena - ScripChangeLoading.ir_para("caminho", self)
func ir_para(path, cena_atual):
	var carregar = ResourceLoader.load_interactive(path)

	if (carregar == null):
#		print("Não carregou ou tem algum erro no arquivo")
		return
	
	var barra_carregamento = load("res://Cenas/Loading/cena_progress_loading.tscn").instance()
	
	get_tree().get_root().call_deferred('add_child',barra_carregamento)
	
	var tempo = OS.get_ticks_msec()
	
	while OS.get_ticks_msec() - tempo < max_tempo_carregamento:
		var err = carregar.poll()
		if(err == ERR_FILE_EOF):
#			Carregamento completo
			var resource = carregar.get_resource()
			get_tree().get_root().call_deferred('add_child', resource.instance())
			cena_atual.queue_free()
			barra_carregamento.queue_free()
			break

		elif(err == OK):
#			Ainda carregando
			var progresso = float(carregar.get_stage())/carregar.get_stage_count()
			barra_carregamento.value = progresso * 100.00
#			print(progresso)
		else:
			print("Erro enquanto carregava o arquivo")
			break
		yield(get_tree(),"idle_frame")
		
	pass
