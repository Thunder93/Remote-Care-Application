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
	// sendCommand@AccessControl({ .smartHome="TestHome" , .deviceItem="TestDevice" , .value="TestValue" })();
	checkWriteAccess@AccessControl({.user=args[0],.smartHome=args[1],.deviceItem=args[2]} )(response);
	println@Console(response)()
}
