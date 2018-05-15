include "console.iol"
include "interface.iol"

inputPort AccessControl {
	Location: "socket://localhost:8123/"
	Protocol: sodep
	Interfaces: AccessInterface
}

outputPort HistoryLogging {
	Location: "socket://localhost:8124/"
	Protocol: sodep
	Interfaces: HistoryInterface
}

execution { sequential }

init {
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
	)
}

main {
	sendCommand(command)(response){
		println@Console("AccessControl recieved Message: "+ command.smartHome+ " "+command.deviceItem +" "+ command.value)();
		logCommand@HistoryLogging(command) |
		response=true
	}
}
