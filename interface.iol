type Command:void {
	.smartHome:string
	.deviceItem:string
	.value:string
	//.commandType:string //Sinn?
}

interface AccessInterface {
RequestResponse:
	sendCommand(Command)(bool)
}
