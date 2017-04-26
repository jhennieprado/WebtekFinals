var loggedUser = "";


var mysql = require('mysql');
var server = require("http");
function submitToDB(post, dbName, tableName) {
	var connection = mysql.createConnection({
		host     : 'localhost',
		user     : 'root',
		password : '',
		database : dbName,
	});
	connection.connect(function(err) {
	    // in case of error
		if(err){
		    console.log(err);
		}
	});
	// submit the data
	connection.query('INSERT INTO '+tableName+' SET ?', post, function(err, result) {});
	// the connection has been closed
	connection.end(function(){});
}

// For file-sourcing (eg. src='script.js') within html files
const http = require('http');
const url = require('url');
const fs = require('fs');
const path = require('path');
// you can pass the parameter in the command line. e.g. node static_server.js 3000
//const port = process.argv[2] || 9000;
http.createServer(function (req, res) {
  console.log(`${req.method} ${req.url}`);
  // parse URL
  const parsedUrl = url.parse(req.url);
  // extract URL path
  let pathname = `.${parsedUrl.pathname}`;
  // maps file extention to MIME types
//console.log(pathname);
  const mimeType = {
    '.ico': 'image/x-icon',
    '.html': 'text/html',
    '.js': 'text/javascript',
    '.json': 'application/json',
    '.css': 'text/css',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.wav': 'audio/wav',
    '.mp3': 'audio/mpeg',
    '.svg': 'image/svg+xml',
    '.pdf': 'application/pdf',
    '.doc': 'application/msword',
    '.eot': 'appliaction/vnd.ms-fontobject',
    '.ttf': 'aplication/font-sfnt'
  };
  fs.exists(pathname, function (exist) {
    if(!exist) {
      // if the file is not found, return 404
      res.statusCode = 404;
      res.end(`File ${pathname} not found!`);
      return;
    }
    // if is a directory, then look for index.html
    if (fs.statSync(pathname).isDirectory()) {
      pathname += '/index.html';
    }
    // read file from file system
    fs.readFile(pathname, function(err, data){
      if(err){
        res.statusCode = 500;
        res.end(`Error getting the file: ${err}.`);
      } else {
        // based on the URL path, extract the file extention. e.g. .js, .doc, ...
        const ext = path.parse(pathname).ext;
        // if the file is found, set Content-type and send data
        res.setHeader('Content-type', mimeType[ext] || 'text/plain' );
        res.end(data);
      }
    });
  });
}).listen(8082);

// Registration Form Server
server.createServer(function(request, response){
    response.writeHead(200, {"Content-Type":"text/html"});
    response.write("<html><head><title>Registration Form</title></head>"+
    	"\n<body>"+
    	"\n<h1>User Registration</h1>"+
    	"<iframe name='sub' id='sub' src='#' style='display: none;'></iframe>"+
    	"\n<form action='http://localhost:8084/' target='sub' name='registration'>"+
    	"\n<label for='name'>LoginID: <label><input name='userid' type='text' value='' required default='codename' />"+
    	"\n<label for='name'>First Name: <label><input name='fname' type='text' value='' required default='Mickey' />"+
    	"\n<label for='name'>Last Name: <label><input name='lname' type='text' value='' required default='Mouse' />"+
    	"\n<label for='name'>Password*: <label><input name='password' type='password' value='' required default='***' />"+
    	"\n<label for='name'>Contact No.: <label><input name='contact' type='text' value='' required default='' />"+
    	"\n<label for='name'>Address*: <label><input name='address' type='text' value='' required default='' />"+
    	"\n<input name='submit' type='submit' value='Submit' />"+
    	"\n</form>"+
    	"\n</body>"+
    	"\n</html>");
    response.end();
    
}).listen(8083);

// Registration Submission Server
server.createServer(function(request, response){

    //if(request.method == "POST") {
	var url = require("url");
	var params = url.parse(request.url, true).query;
	    //if(params.userid == null) return false; // to avoid resubmitting of params with undefined values

	var userid = new String(params.userid);
	var password = new String(params.password);
	var fname = new String(params.fname);
	var lname = new String(params.lname);
	var contact = new String(params.contact);
	var address = new String(params.address);
	var post = {userid, password, fname, lname, contact, address};

	// insert the data to the database
	submitToDB(post, "wt_user", "user_details");

	response.writeHead(200, {"Content-Type":"text/html"});
	response.write("<html><head><title>Registration Submitted</title></head><body></body></html>");
	response.end();
   // }

}).listen(8084);



// Log In Server
server.createServer(function(request, response){
	var url = require("url");
    var params = url.parse(request.url, true).query;

    var user = params.user;
    var passwd = params.passwd;
    if(params.user && params.passwd && loggedUser == "") {
		var connection = mysql.createConnection({
			host     : 'localhost',
			user     : 'root',
			password : '',
			database : 'wt_user',
		});
		connection.connect(function(err) {
		    // in case of error
			if(err){
			    console.log(err);
			}
		});
		connection.query("SELECT * from user_details where (userid='"+user+"' and password='"+passwd+"')", 
		function(err, rows, fields) {
		    if(err){console.log(err);return;}

		    if(rows.length == 1) { // match
		    	console.log("logged in!"); // what to do?
		    	loggedUser = user;
		    	console.log(loggedUser);

				response.writeHead(200, {"Content-Type":"text/html"});
				response.write("<html><head><title>Log In</title>"+
				"<script type='text/javascript'>window.location.reload()</script>"+
				"</head><body></body></html>");
			    response.end();

		    } else {
				response.writeHead(200, {"Content-Type":"text/html"});
				response.write("<h1>Invalid Credentials.</h1>");
			    response.end();
		    }
		});
		connection.end(function(){});
		return false; // terminate here | the page will reload once if accepted
    }

	response.writeHead(200, {"Content-Type":"text/html"});
	response.write("<html><head><title>Log In</title>"+
	"<script type='text/javascript'>if("+loggedUser+".length > 0){widow.location.reload();}</script>"+
	"</head><body>");
    if(loggedUser == "") {	
		response.write("<form name='login' action='http://localhost:8085/' target='_top'>"+
			"Userid: <input type='text' name='user'> <br>"+
			"Password: <input type='password' name='passwd'> <br>"+
			"<input type='submit' value='login'>"+
			"</form>");
	} else {
		response.write("<h1>You are already logged in.</h1>");
	}
	response.write("</body></html>");
    response.end();

}).listen(8085);



// Chatbox Form Server
server.createServer(function(request, response){
	var url = require("url");
    var params = url.parse(request.url, true).query;
    console.log(params);

    response.writeHead(200, {"Content-Type":"text/html"});
    response.write("<html>"+
    	"\n<head>\n<title>Chatbox Form</title>"+
    	"\n<link rel='stylesheet' type='text/css' href='http://localhost:8082/chat-style.css' />"+
    	"\n<script type='text/javascript' src='http://localhost:8082/chat-script.js'></script>"+
    	"\n<script type='text/javascript'>\nvar sender=\""+params.sender+"\";\nvar receiver=\""+params.receiver+"\";\n</script>"+
    	"\n</head>"+
    	"\n<body>"+
    	"\n<h1>Node.js Chatbox (User 1)</h1>"+
    	"\n<iframe name='chatsubmit' id='chatsubmit' src='#' style='display: none;'></iframe>"+
    	"\n<form id='chatbox' action='http://localhost:8087/' target='chatsubmit' name='chatbox'>"+
    	"\n<div id='messages'></div>"+
    	"\n<label for='sender'>Name: </label>"+
    	"\n<input class='text' name='sender' type='text' value='" + params.sender +"' required />"+
    	"\n<label for='msg'>Message: </label><textarea class='text' name='msg'></textarea>"+
    	"\n<input name='receiver' type='hidden' value='"+params.receiver+"' />"+
    	"\n<input class='button' type='submit' value='Submit' />"+
    	"\n<input class='button'  type='reset' value='Reset' />"+
    	"\n</form>"+
    	"\n<script type='text/javascript'>setTimeout(function(){fetchNewChatData();}, 3000);</script>"+
    	"\n</body>"+
    	"\n</html>");
    response.end();
}).listen(8086);

// Chatbox Submission Server
server.createServer(function(request, response){
	var url = require("url");
    var params = url.parse(request.url, true).query;
    var sender = params.sender;
    var receiver = params.receiver;
    var message = params.msg;
	var post = {sender, receiver, message};

	submitToDB(post, "wt_user", "messages");

	response.writeHead(200, {"Content-Type":"text/html"});
	response.write("<html><head><title>Message Sent</title></head><body></body></html>");
    response.end();
}).listen(8087);

//Chatbox Message-Fetching Server
/*
var g="global";
server.createServer(function(request, response){
	var url = require("url");
    var params = url.parse(request.url, true).query;
    var sender = params.sender;
    var receiver = params.receiver;

	var connection = mysql.createConnection({
		host     : 'localhost',
		user     : 'root',
		password : '',
		database : 'wt_user',
	});
	connection.connect(function(err) {
	    // in case of error
		if(err){
		    console.log(err);
		}
	});
	var result = "";
	connection.query("SELECT * from messages where (sender='"+sender+"' and receiver='"+receiver+"') OR "+
	"(receiver='"+sender+"' and sender='"+receiver+"')", function(err, rows, fields) {
	    if(err){
	        console.log(err);
	        return;
	    }
	});
	return result;

	response.writeHead(200, {"Content-Type":"text/html"});
	response.write("<html><head><title>Message Sent</title></head><body></body></html>");
    response.end();
}).listen(8087);
*/




/*
function getDataFromDB(q) {
	$query = q;
	connection.query($query, function(err, rows, fields) {
	    if(err){
	        console.log(err);
	        return;
	    }
	    console.log("Query succesfully executed: ", rows);
	    return rows;
	});
}*/

// Perform a query
//var post  = {userid: 'god', pw: 'noone'};
//var post  = {userid: 'jama', pw: 'chin'};



//console.log(query.sql); // INSERT INTO posts SET `id` = 1, `title` = 'Hello MySQL'


/*
$query = 'SELECT * from city';
connection.query($query, function(err, rows, fields) {
    if(err){
        console.log(err);
        return;
    }

    console.log("Query succesfully executed: ", rows);
});
*/

// Close the connection
