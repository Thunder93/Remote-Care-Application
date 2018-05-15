include "console.iol"
include "interface.iol"

inputPort HistoryLogging {
	Location: "socket://localhost:8124/"
	Protocol: sodep
	Interfaces: HistoryInterface
}

execution { concurrent }

init {
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
	)
}

main {	
	logCommand(command);
	println@Console("Logging Command:" + command.smartHome+ " "+ command.deviceItem +" "+ command.value)()
}