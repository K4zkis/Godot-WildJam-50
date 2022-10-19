extends Node2D


export var mainGameScene : PackedScene
export var OptionsScene : PackedScene
export var CreditsScene : PackedScene


func _on_Start_Button_button_up():
	get_tree().change_scene(mainGameScene.resource_path)


func _on_Options_Button_button_up():
	get_tree().change_scene(OptionsScene.resource_path)


func _on_Credits_Button_button_up():
	get_tree().change_scene(CreditsScene.resource_path)
	
