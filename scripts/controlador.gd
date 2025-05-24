extends Node2D
@onready var player: CharacterBody2D = $player

var botao
var forma

var formas = {
	"circulo": preload("res://player_circulo.tscn"),
	"triangulo": preload("res://player_triangulo.tscn"),
	"quadrado": preload("res://player_quadrado.tscn")
}

func _physics_process(delta):
	if (Input.is_action_just_pressed("troca_proximo")):
		botao = 'proximo'
		forma = player.forma
		troca(forma,botao)
	
	if (Input.is_action_just_pressed("torca_anterior")):
		botao = 'anterior'
		forma = player.forma
		troca(forma,botao)


func troca(forma,botao):
	match botao:
		'proximo':
			match forma:
				'quadrado':
					forma = 'triangulo'
					var posicao = player.position
					player.queue_free()
					var outra_forma = formas[forma].instantiate()
					outra_forma.position = posicao
					add_child(outra_forma)
					player = outra_forma
					
				'triangulo':
					forma = 'circulo'
					var posicao = player.position
					player.queue_free()
					var outra_forma = formas[forma].instantiate()
					outra_forma.position = posicao
					add_child(outra_forma)
					player = outra_forma
					
				'circulo':
					forma = 'quadrado'
					var posicao = player.position
					player.queue_free()
					var outra_forma = formas[forma].instantiate()
					outra_forma.position = posicao
					add_child(outra_forma)
					player = outra_forma
					
		'anterior':
			match forma:
				'quadrado':
					forma = 'circulo'
					var posicao = player.position
					player.queue_free()
					var outra_forma = formas[forma].instantiate()
					outra_forma.position = posicao
					add_child(outra_forma)
					player = outra_forma
					
				'triangulo':
					forma = 'quadrado'
					var posicao = player.position
					player.queue_free()
					var outra_forma = formas[forma].instantiate()
					outra_forma.position = posicao
					add_child(outra_forma)
					player = outra_forma
					
				'circulo':
					forma = 'triangulo'
					var posicao = player.position
					player.queue_free()
					var outra_forma = formas[forma].instantiate()
					outra_forma.position = posicao
					add_child(outra_forma)
					player = outra_forma
