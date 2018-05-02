include "console.iol"
include "interface.iol"

outputPort AccessControl {
Location: "socket://localhost:8123/"
Protocol: sodep
Interfaces: AccessInterface
}

main
{
	debug = true; //TODO make global somehow
	if(debug){	// gib alle übergebenen Argumente aus
		arguments="";
		for(i=0,i<#args,i++){
			arguments=arguments+"Args["+i+"]: "+args[i]+" "
		};
		println@Console(arguments)()
	};
	// sendCommand@AccessControl({ .smarthome="Test" , .deviceItem=args[1] , .value=args[2] })();
	sendCommand@AccessControl({.smartHome=args[0],.deviceItem=args[1], .value=args[2]})(response);
	println@Console(response)()
}
