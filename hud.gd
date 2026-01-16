extends CanvasLayer


func update_health() -> void:
	$ProgressBar.value = Globals.player_health
