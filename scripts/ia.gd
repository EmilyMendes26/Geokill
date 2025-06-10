extends Node2D
@onready var timer: Timer = $Timer

var player
const largura_mapa = 10
const limite_mapa = (largura_mapa * 16)/2
var heuristica_circulo = 100
var heuristica_triangulo = 50
var heuristica_quadrado = 0
var formas
var player_forma

func _ready() -> void:
	timer.start()
	randomize()

#func _physics_process(delta):

func gerar_posicoes_x(largura: int, tamanho_tile: int) -> Array:
	var limite = (largura * tamanho_tile) / 2
	var posicoes = []
	
	for i in range(largura):
		var x = -limite + (i * tamanho_tile) + tamanho_tile / 2
		posicoes.append(x)
		
	return posicoes

func spawn_inimigo(forma_escolhida):	
	var inimigo = formas[forma_escolhida]["arquivo"].instantiate()
	var eixo_x
	var topo
	var posicao_x
	topo = player.position.y * (-1)
	posicao_x = gerar_posicoes_x(largura_mapa,16)
	eixo_x = posicao_x[randi() % posicao_x.size()]
		
	inimigo.position = Vector2(eixo_x, topo)
	add_child(inimigo)
	
func define_heuristica(forma_player)-> Dictionary:
	var heuristica_circulo = 0
	var heuristica_triangulo = 0
	var heuristica_quadrado = 0
	
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
	var forma_escolhida
	var maior_custo = 0
	var custo = 0
	
	for nome_forma in formas.keys():
		custo = formas[nome_forma]["custo"]
		
		if custo > maior_custo:
			maior_custo = max(custo, maior_custo)
			forma_escolhida = nome_forma
			
	if maior_custo != 0:
		return forma_escolhida
	
func get_player():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		return players[0]
	return null

func _on_timer_timeout() -> void:
	player = get_player()
	if player == null:
		return
	else:
		player_forma = player.forma 
		
	var forma_escolhida
	formas = define_heuristica(player_forma)
	forma_escolhida = algoritmo_guloso(formas)
	spawn_inimigo(forma_escolhida)
