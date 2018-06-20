include "console.iol"
include "interface.iol"

inputPort RemoteControl {
	Location: "socket://localhost:8125/"
	Protocol: sodep
	Interfaces: SmartHomeClientInterface
}

outputPort HistoryLogging {
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
		sendCommand(command)(response) {
			println@Console("Device " + command.deviceItem + " at SmartHome " + command.smartHome + " has executed command.")() ;
			response = true
			|
			logCommand@HistoryLogging(command)
		}
	}
