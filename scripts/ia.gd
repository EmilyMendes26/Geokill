extends Node2D
@onready var player: CharacterBody2D = $"../player"
@onready var timer: Timer = $Timer

const altura_mapa = 4
const largura_mapa = 8
const limite_mapa = (largura_mapa * 16)/2
const topo = -(16*altura_mapa)
var heuristica_circulo = 100
var heuristica_triangulo = 50
var heuristica_quadrado = 0
var formas
var player_forma

##ARRUMAR O JEITO QUE A HEURISTICA ESTA SENDO PASSADA DINAMICAMENTE

func _ready() -> void:
	timer.start()
	randomize()
	formas = define_heuristica('circulo')
	print(formas)
	formas = define_heuristica('circulo')
	print(formas)
	formas = define_heuristica('circulo')
	print(formas)

#func _physics_process(delta):


func spawn_inimigo(forma_escolhida):	
	var inimigo = formas[forma_escolhida]["arquivo"].instantiate()
	var eixo_x
	if (player.position.x + 16 <= limite_mapa):
		eixo_x = player.position.x + 16
	else:
		eixo_x = player.position.x - 16
		
	inimigo.position = Vector2(eixo_x, topo)
	add_child(inimigo)
	
func define_heuristica(forma_player)-> Dictionary:
	var heuristica_circulo
	var heuristica_triangulo
	var heuristica_quadrado
	
	var numero = randi_range(50, 100)
	var numero2 = randi_range(50,100)
	
	match forma_player:
		'circulo':
			heuristica_circulo = 0
			heuristica_triangulo = numero
			heuristica_quadrado = numero2
			
		'triangulo':
			heuristica_triangulo = 0
			heuristica_quadrado = numero2
			heuristica_circulo = numero
		'quadrado':
			heuristica_quadrado = 0
			heuristica_triangulo = numero
			heuristica_circulo = numero2
	var formas = {
	'circulo': {
		"arquivo": preload("res://inimigo_circulo.tscn"),
		"custo" : heuristica_circulo 
		},
		
	'quadrado': {
		"arquivo": preload("res://inimigo_quadrado.tscn"),
		"custo": heuristica_quadrado
		},
		
	'triangulo':{
		"arquivo": preload("res://inimigo_triangulo.tscn"),
		"custo": heuristica_triangulo
		}
	}
	return formas

func algoritmo_guloso(formas):
	var melhor_forma
	var maior_custo

func _on_timer_timeout() -> void:
	spawn_inimigo('circulo')
