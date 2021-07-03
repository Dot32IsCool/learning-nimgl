#? replace(sub = "\t", by = " ")
import nimgl/[glfw, opengl]

type colour = tuple[r: float, g: float, b: float]
const gray: colour  = (r: 0.17, g: 0.17, b: 0.17)
const red: colour  = (r: 0.5, g: 0.17, b: 0.17)

var backgroundColour = gray

proc windowCloseCallback(window: GLFWWindow): void {.cdecl.} = 
	if backgroundColour == gray:
		window.setWindowShouldClose(false)
		backgroundColour = red
		echo "why you do this to me!"

proc keyProc(window: GLFWWindow, key: int32, scancode: int32,
						 action: int32, mods: int32): void {.cdecl.} =
	if key == GLFWKey.W and action == GLFWPress:
		window.setWindowShouldClose(true)
		window.windowCloseCallback()
	# echo key

proc main() =
	assert glfwInit()

	glfwWindowHint(GLFWContextVersionMajor, 3)
	glfwWindowHint(GLFWContextVersionMinor, 3)
	glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE) # Used for Mac
	glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
	glfwWindowHint(GLFWResizable, GLFW_TRUE)
	# glfwWindowHint(GLFWMaximized, GLFW_TRUE)
	# glfwWindowHint(GLFW_TRANSPARENT_FRAMEBUFFER, GLFW_TRUE)
	glfwWindowHint(GLFW_COCOA_RETINA_FRAMEBUFFER, GLFW_TRUE)

	let w: GLFWWindow = glfwCreateWindow(800, 600, "Learning NimGL")
	if w == nil:
		quit(-1)

	discard w.setWindowCloseCallback(windowCloseCallback)
	discard w.setKeyCallback(keyProc)
	w.makeContextCurrent()

	assert glInit()

	while not w.windowShouldClose:
		glfwPollEvents()
		glClearColor(backgroundColour.r, backgroundColour.g, backgroundColour.b, 1)
		# glClearColor(0f, 0f, 0f, 0.3f)
		glClear(GL_COLOR_BUFFER_BIT)
		w.swapBuffers()

	w.destroyWindow()
	glfwTerminate()

main()