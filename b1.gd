extends Node2D

onready var bg_texture_rect = $Control/background
onready var audio_player = $Control/AudioStreamPlayer

var button_container
var text_segments = []
var is_audio_playing = false
var tween = Tween.new()  
var config = ConfigFile.new()  
const SAVE_PATH = "user://bg_save.cfg"  

var current_segment_index = 0  # 新增：保存当前文本段落的索引
var last_image_index = 0

var last_image_file_path = ""
var current_file_path = ""

var is_transitioning = false
var is_showing_buttons = false
var label_node = null
var exit_button = null
var scroll_container = null

func update_background_image(image_path):
	var target_texture = load(image_path.strip_edges())  
	if target_texture:
		if bg_texture_rect.texture   != target_texture:
			tween.interpolate_property(bg_texture_rect,   "modulate",
				bg_texture_rect.modulate,   Color(1, 0.9, 0.8, 0), 0.6,
				Tween.TRANS_SINE, Tween.EASE_IN)
			tween.interpolate_callback(self,   0.6, "_apply_new_texture", target_texture)
			tween.start()  
	else:
		print("无效背景路径:", image_path)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit()

func save_progress():
	config.set_value("progress",   "last_image_file_path", last_image_file_path)
	config.set_value("progress",   "last_image_index", last_image_index)  # 新增：保存当前文本段落的索引
	config.save(SAVE_PATH)  

func load_progress():
	if config.load(SAVE_PATH)   == OK:
		last_image_file_path = config.get_value("progress",   "last_image_file_path", "")
		last_image_index = config.get_value("progress",   "last_image_index", 0)  # 新增：加载当前文本段落的索引
		return true
	return false

func _ready():
	var screen_size = OS.get_screen_size() 
	var aspect_ratio = float(screen_size.x) / float(screen_size.y)
	if aspect_ratio <= 1.8 && aspect_ratio > 1.4:
		print("16:9")
		OS.set_window_size(Vector2(2400,1350))
	if aspect_ratio >= 1.8:
		print("21:9")
		OS.set_window_size(Vector2(2400,1080))
	if aspect_ratio <= 1.4:
		print("4:3")
		OS.set_window_size(Vector2(2400,1800))

	add_child(tween)
	audio_player.volume_db   = -10
	bg_texture_rect.modulate   = Color(1, 0.95, 0.9, 1)

	if load_progress():
		# 有存档的情况下如何处理
		print(last_image_file_path)
		print(last_image_index)
		current_segment_index = last_image_index
		load_text_file_p(last_image_file_path)
	else:
		# 没存档的情况下，就从头开始
		load_text_file("res://b1p/b1.tres")

	button_container = HBoxContainer.new()  
	button_container.name   = "ButtonContainer"
	button_container.rect_min_size   = Vector2(600, 120)
	button_container.rect_position   = Vector2(50, 350)
	button_container.set("custom_constants/separation",   20)
	$Control.add_child(button_container)  

	create_exit_button()

func _apply_new_texture(new_texture):
	bg_texture_rect.texture   = new_texture
	tween.interpolate_property(bg_texture_rect,   "modulate",
		Color(1, 0.95, 0.9, 0), Color(1, 0.95, 0.9, 1), 0.8, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()  

func show_next_text_segment():
	if is_transitioning: return
	stop_audio_if_playing()

	if text_segments.size()   > current_segment_index + 1:
		current_segment_index += 1  # 新增：更新当前文本段落的索引
		parse_and_display_segment(text_segments[current_segment_index].strip_edges())
	else:
		print("已到达文本末尾，暂停显示")
		delete_save_file()

func load_text_file(file_path):
	var file = File.new()  
	if file.file_exists(file_path):  
		file.open(file_path,   File.READ)
		var full_text = file.get_as_text()  
		text_segments = full_text.split("\n\n")    # 严格使用双换行符分割
		file.close()
		current_file_path = file_path
		current_segment_index = 0  # 新增：重置当前文本段落的索引
		parse_and_display_segment(text_segments[current_segment_index].strip_edges())
	else:
		print("文件不存在: ", file_path) 

func load_text_file_p(file_path):
	var file = File.new()  
	if file.file_exists(file_path):  
		file.open(file_path,   File.READ)
		var full_text = file.get_as_text()  
		text_segments = full_text.split("\n\n")    # 严格使用双换行符分割
		file.close()
		current_file_path = file_path
		parse_and_display_segment(text_segments[current_segment_index].strip_edges())
	else:
		print("文件不存在: ", file_path) 

func _input(event):
	# 优先处理退出按钮的触摸/点击 
	if exit_button and (
		(event is InputEventScreenTouch and event.pressed  and 
		 exit_button.get_global_rect().has_point(event.position))  or 
		(event is InputEventMouseButton and event.pressed  and 
		 exit_button.get_global_rect().has_point(event.position)) 
	):
		_on_exit_button_pressed()
		get_tree().set_input_as_handled()  # 关键：阻止事件继续传播 
		return 
 
	# 阻止其他操作在过渡期间执行 
	if is_transitioning || is_showing_buttons: 
		return 
 
	# 处理常规点击 
	if (event is InputEventScreenTouch && event.pressed)  || \
	   (event is InputEventMouseButton && event.pressed  && event.button_index  == BUTTON_LEFT):
		show_next_text_segment()
		get_tree().set_input_as_handled()

func create_decision_buttons(options, paths):
	if label_node:
		label_node.queue_free()  
		label_node = null

	for child in button_container.get_children():  
		child.queue_free()  

	var style = StyleBoxFlat.new()  
	style.bg_color   = Color(0.5, 0.5, 0.5, 0.7)
	style.set_border_width_all(2)  
	style.border_color   = Color(0.9, 0.9, 0.9)
	style.set_corner_radius_all(8)  
	style.content_margin_left   = 10
	style.content_margin_right   = 10
	style.content_margin_top   = 10
	style.content_margin_bottom   = 10

	var font = DynamicFont.new()  
	font.font_data   = load("res://ziti/Alibaba-PuHuiTi-Regular.ttf")  
	font.size   = 70

	for i in range(options.size()):  
		var button = Button.new()  
		button.text   = options[i]
		button.clip_text   = false
		button.align   = Button.ALIGN_LEFT
		button.add_font_override("font",   font)
		button.rect_min_size   = Vector2(clamp(font.get_string_size(options[i]).x   + 40, 300, 600), 100)
		button.size_flags_horizontal   = Control.SIZE_EXPAND_FILL
		button.add_stylebox_override("normal",   style)
		var target_path = paths[i] if i < paths.size()   else ""
		button.connect("pressed",   self, "_on_option_selected", [target_path])
		button_container.add_child(button)  

	var btn_scroll = ScrollContainer.new()  
	btn_scroll.rect_min_size   = Vector2(2000, 400)
	btn_scroll.rect_position   = Vector2(50, 500)
	$Control.remove_child(button_container)  
	btn_scroll.add_child(button_container)  
	$Control.add_child(btn_scroll)  

func parse_and_display_segment(segment):
	if not label_node:
		create_label()

	label_node.text   = ""

	var current_options = []
	var current_paths = []
	var lines = segment.split("\n")  

	for line in lines:
		line = line.strip_edges()  
		if line.begins_with("#"):  
			play_audio(line.replace("#",   ""))
		elif line.begins_with("$"):  
			#存档点----------------------------------------------------
			last_image_file_path = current_file_path
			last_image_index = current_segment_index
			save_progress()
			update_background_image(line.replace("$",   ""))
		elif line.begins_with("?"):  
			current_options.append(line.replace("?",   "").strip_edges())
		elif line.begins_with("&"):  
			current_paths.append(line.replace("&",   "").strip_edges())
		else:
			append_text(line + "\n")

	if current_options.size()   > 0:
		is_showing_buttons = true
		create_decision_buttons(current_options, current_paths)
	else:
		is_showing_buttons = false

func append_text(text):
	if label_node:
		label_node.text   += text

func play_audio(audio_path):
	var path = audio_path.strip_edges()  
	if not path: return

	var audio_stream = ResourceLoader.load(path)  
	if audio_stream:
		stop_audio_if_playing()
		audio_player.stream   = audio_stream
		if audio_player.is_connected("finished",   self, "_on_audio_finished"):
			audio_player.disconnect("finished",   self, "_on_audio_finished")
		audio_player.connect("finished",   self, "_on_audio_finished")
		audio_player.play()  
		is_audio_playing = true
	else:
		print("无法加载音频: ", path)

func stop_audio_if_playing():
	if is_audio_playing:
		if audio_player.is_connected("finished",   self, "_on_audio_finished"):
			audio_player.disconnect("finished",   self, "_on_audio_finished")
		audio_player.stop()  
		is_audio_playing = false

func _on_audio_finished():
	is_audio_playing = false
	print("音频播放已完成")

func delete_save_file():
	var dir = Directory.new()  
	if dir.file_exists(SAVE_PATH):  
		dir.remove(SAVE_PATH)  
		print("存档文件已删除")
	else:
		print("存档文件不存在，无需删除")

func create_label():
	scroll_container = ScrollContainer.new()  
	scroll_container.rect_min_size   = Vector2(2200, 400)
	scroll_container.rect_position   = Vector2(100, 600)
	scroll_container.scroll_horizontal_enabled   = false

	label_node = Label.new()  
	label_node.rect_min_size   = Vector2(2200, 0)
	label_node.size_flags_vertical   = Control.SIZE_EXPAND_FILL
	label_node.autowrap   = true
	label_node.valign   = Label.VALIGN_TOP
	label_node.add_color_override("font_color",   Color(1, 1, 1))
	label_node.add_color_override("font_color_shadow",   Color(0, 0, 0, 0.5))
	label_node.add_constant_override("shadow_offset_x",   2)
	label_node.add_constant_override("shadow_offset_y",   2)
	label_node.add_constant_override("line_spacing",   10)

	var label_style = StyleBoxFlat.new()  
	label_style.bg_color   = Color(0.2, 0.2, 0.2, 0.6)
	label_style.set_corner_radius_all(8)  
	label_style.content_margin_left   = 20
	label_style.content_margin_right   = 20
	label_style.content_margin_top   = 20
	label_style.content_margin_bottom   = 20
	label_node.add_stylebox_override("normal",   label_style)

	var font = DynamicFont.new()  
	font.font_data   = load("res://ziti/Alibaba-PuHuiTi-Regular.ttf")  
	font.size   = 75
	label_node.add_font_override("font",   font)

	scroll_container.add_child(label_node)  
	$Control.add_child(scroll_container)  

func create_exit_button():
	exit_button = Button.new()  
	exit_button.text   = "quit"
	exit_button.clip_text   = false
	exit_button.rect_min_size   = Vector2(150, 80)
	exit_button.rect_position   = Vector2(2205, 25)

	var style = StyleBoxFlat.new()  
	style.bg_color   = Color(0.5, 0.5, 0.5, 0.7)
	style.set_corner_radius_all(8)  
	exit_button.add_stylebox_override("normal",   style)

	var font = DynamicFont.new()  
	font.font_data   = load("res://ziti/Alibaba-PuHuiTi-Regular.ttf")  
	font.size   = 50
	exit_button.add_font_override("font",   font)

	exit_button.connect("pressed",   self, "_on_exit_button_pressed")
	$Control.add_child(exit_button)  

func _on_exit_button_pressed():
	get_tree().quit()

func _on_option_selected(target_path):
	is_showing_buttons = false
	for child in button_container.get_children():  
		child.queue_free()  

	if target_path != "":
		load_text_file(target_path)  # 此处已包含显示逻辑
	else:
		show_next_text_segment()
