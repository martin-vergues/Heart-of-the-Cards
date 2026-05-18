extends Node

class_name ThreadManager

var threadPool: Array[Thread]

# The thread will start here.
func _ready():
	for i in range(5):
		threadPool.push_back(Thread.new())
	# You can bind multiple arguments to a function Callable.

# Run here and exit.
# The argument is the bound data passed from start().

func _get_available_thread():
	for thread in threadPool:
		if !thread.is_started():
			return thread
	threadPool.push_back(Thread.new())
	return threadPool.back()

#func _thread_function(card: Card):
	#for thread in threadPool:
		#if !thread.is_started():
			#thread.start($Card_functions.func_array[card.id].bind(card))
			#break
	# Print the userdata ("Wafflecopter")


# Thread must be disposed (or "joined"), for portability.
func _exit_tree():
	pass
	#thread.wait_to_finish()
