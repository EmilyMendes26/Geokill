extends CharacterBody2D

@export var posicao: Vector2
const largura_mapa = 8
const tamanho_mapa = 16
var limite_mapa = (16 * largura_mapa)/2
var tiro = preload("res://tiro.tscn")

func _ready():
	posicao = position
	add_to_group("player")
	
func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("direita") && position.x + tamanho_mapa <= limite_mapa):
		position.x += tamanho_mapa
	if (Input.is_action_just_pressed("esquerda") && position.x - tamanho_mapa >= -limite_mapa):
		position.x -= tamanho_mapa
	if (Input.is_action_just_pressed("tiro")):
		atirar()
		
func atirar():
	var tiro = tiro.instantiate() #prepara o tiro para ser instanciado
	tiro.global_position = global_position
	get_tree().root.add_child(tiro) #Instancia o tiro no mundo e adiciona ao mesmo nivel que o jogador na hierarquia
