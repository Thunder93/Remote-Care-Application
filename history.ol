include "console.iol"
include "interface.iol"

inputPort HistoryLogging {
	Location: "socket://localhost:8124/"
	Protocol: sodep
	Interfaces: HistoryInterface
}

execution { concurrent }

define initSmartHome {
	
	with(global.smartHomes[index]) {
		.name = "Home" + index;
		.deviceItems[0].name = "TV";	
		.deviceItems[0].itemStates[0].value = "On";	
		.deviceItems[0].itemStates[0].timestamp = "0";
		.deviceItems[1].name = "Radio";	
		.deviceItems[1].itemStates[0].value = "On";	
		.deviceItems[1].itemStates[0].timestamp = "0"
	}
}

init {
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
	);
	
	index = 0;
	initSmartHome;
	index = 1;
	initSmartHome
}

main {	
	logCommand(command);
	{
	println@Console("Logging Command:" + command.smartHome+ " "+ command.deviceItem +" "+ command.value)()
	}
}