include "console.iol"
include "interface.iol"

inputPort AccessControl {
	Location: "socket://localhost:8123/"
	Protocol: sodep
	Interfaces: AccessInterface
}

execution { concurrent }

init {
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
	)
}

main {
	[checkWriteAccess(AccessRequest)(response){
		println@Console("AccessControl recieved Message: "+AccessRequest.user +" "+ AccessRequest.smartHome +" "+AccessRequest.deviceItem )();
		response=true
	}]
	[checkReadAccess(AccessRequest)(response){
		println@Console("AccessControl recieved Message: "+AccessRequest.user +" "+ AccessRequest.smartHome +" "+AccessRequest.deviceItem )();
		response=true
	}]
}
