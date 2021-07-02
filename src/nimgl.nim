#? replace(sub = "\t", by = " ")
import nimgl/[glfw, opengl]

proc keyProc(window: GLFWWindow, key: int32, scancode: int32,
						 action: int32, mods: int32): void {.cdecl.} =
	if key == GLFWKey.ESCAPE and action == GLFWPress:
		window.setWindowShouldClose(true)
	echo key

proc main() =
	assert glfwInit()

	glfwWindowHint(GLFWContextVersionMajor, 3)
	glfwWindowHint(GLFWContextVersionMinor, 3)
	glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE) # Used for Mac
	glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
	glfwWindowHint(GLFWResizable, GLFW_TRUE)
	# glfwWindowHint(GLFWMaximized, GLFW_TRUE)
	glfwWindowHint(GLFW_TRANSPARENT_FRAMEBUFFER, GLFW_TRUE)

	let w: GLFWWindow = glfwCreateWindow(800, 600, "Learning NimGL")
	if w == nil:
		quit(-1)

	discard w.setKeyCallback(keyProc)
	w.makeContextCurrent()

	assert glInit()

	while not w.windowShouldClose:
		glfwPollEvents()
		# glClearColor(0.17f, 0.17f, 0.17f, 1f)
		glClearColor(0f, 0f, 0f, 0.3f)
		glClear(GL_COLOR_BUFFER_BIT)
		w.swapBuffers()

	w.destroyWindow()
	glfwTerminate()

main()