include "console.iol"
include "interface.iol"
include "database.iol"

inputPort AccessControl {
	Location: "socket://localhost:8123/"
	Protocol: sodep
	Interfaces: AccessInterface
}

execution { concurrent }

init {
	install( TypeMismatch =>
				println@Console( "TypeMismatch: " + main.TypeMismatch )()
	);
	with ( connectionInfo ){
	    .host = "localhost";
	    .driver = "mysql";
	    .port = 3306;
	    .database = "world?useSSL=false";
	    .username = "root";
	    .password = "root"
	};
	  connect@Database(connectionInfo )(void);
	  checkConnection@Database( void )( void );
	  println@Console("Connected  to  database .")();
	  scope ( createTable ) {
	        install ( SQLException => println@Console("AccessControl table already there")() );
	        updateRequest ="CREATE TABLE accessControl(user VARCHAR(50) NOT NULL, " +
	            "smartHome VARCHAR(50) NOT NULL, deviceItem VARCHAR(50) NOT NULL, " +
	            "allowedWrite boolean NOT NULL default 0,allowedRead boolean NOT NULL default 0," +
	            "PRIMARY KEY(user, smartHome,deviceItem))";
	        update@Database( updateRequest )( ret );
					println@Console("Created AccessTable")()
	  };
		scope(insertSampleData){
			install ( SQLException => println@Console("SampleData already there")() );
		  updateRequest="INSERT INTO accesscontrol VALUES "+
			"('Anna','Home1','TV',true,true),"+
			"('Anna','Home1','Radio',true,true),"+
			"('Anna','Home2','TV',false,true),"+
			"('Anna','Home2','Radio',false,false);";
			update@Database( updateRequest )( ret );
			println@Console("Added SampleData")()
		}
}

main {
	[checkWriteAccess(AccessRequest)(response){
		println@Console("AccessControl.checkWriteAccess recieved Message: "+AccessRequest.user +" "+ AccessRequest.smartHome +" "+AccessRequest.deviceItem )();
		//queryRequest = "select * from accesscontrol where user=:user";
		//queryRequest.user = "Anna"; //supposed to work but doesn't...
		queryRequest= "select allowedWrite from accessControl where user='"+AccessRequest.user +
									"' AND smartHome='"+AccessRequest.smartHome +
									"' AND deviceItem='"+AccessRequest.deviceItem + "';";
		//println@Console(queryRequest)();
		query@Database(queryRequest)(queryResponse);
		if (#queryResponse.row == 1) {
            response -> queryResponse.row[0].allowedWrite
    }
	}]
	[checkReadAccess(AccessRequest)(response){
		println@Console("AccessControl.checkReadAccess recieved Message: "+AccessRequest.user +" "+ AccessRequest.smartHome +" "+AccessRequest.deviceItem )();
		queryRequest= "select allowedRead from accessControl where user='"+AccessRequest.user +
									"' AND smartHome='"+AccessRequest.smartHome +
									"' AND deviceItem='"+AccessRequest.deviceItem + "';";
		query@Database(queryRequest)(queryResponse);
		if (#queryResponse.row == 1) {
	         response -> queryResponse.row[0].allowedRead
	  }
	}]
}
