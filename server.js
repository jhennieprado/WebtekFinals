var mysql      = require('mysql');
var server = require("http");


// Registration Form Server
server.createServer(function(request, response){
    response.writeHead(200, {"Content-Type":"text/html"});
    response.write("<html><head><title>Registration Form</title></head>"+
    	"\n<body>"+
    	"\n<h1>User Registration</h1>"+
    	"<iframe name='sub' id='sub' src='#' style='display: none;'></iframe>"+
    	"\n<form action='http://localhost:8083/' target='_top' name='registration'>"+
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
    
}).listen(8082);


// Registration Submission Server
server.createServer(function(request, response){
    response.writeHead(200, {"Content-Type":"text/html"});
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

    response.write("<html><head><title>Registration Status</title></head><body>Welcome UserId: " + userid + "!</body></html>");
    response.end();

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

	// submit the data
	connection.query('INSERT INTO user_details SET ?', post, function(err, result) {});

    // the connection has been closed
    connection.end(function(){});

}).listen(8083);

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
}).listen(parseInt(8084));

// Chatbox Server
server.createServer(function(request, response){
	var url = require("url");
    var params = url.parse(request.url, true).query;
    var submit = new String(params.chatsubmit);
    if(submit == "true") {
    	// do something for the chat submission

    	return false;
    }

    response.writeHead(200, {"Content-Type":"text/html"});
    response.write("<html>"+
    	"<head><title>Chatbox Form</title>"+
    	"<link rel='stylesheet' type='text/css' href='http://localhost:8084/chat-style.css' />"+
    	"<script type='text/javascript' src='http://localhost:8084/chat-script.js'></script>"+
    	"</head>"+
    	"\n<body>"+
    	"\n<h1>Node.js Chatbox (User 1)</h1>"+
    	"\n<form id='chatbox' method='post' action='http://localhost:8083/' target='chatsubmit' name='chatbox'>"+
    	"<div id='messages'></div>"+
    	"<iframe name='chatsubmit' src='#' style='display: none;'></iframe>"+
    	"\n<label for='name'>Name: </label><input class='text' name='name' type='text' value='Test1' required default='codename' />"+
    	"\n<label for='msg'>Message: </label><textarea class='text' name='msg'></textarea>"+
    	"\n<input name='chatsubmit' type='hidden' value='true' />"+
    	"\n<input class='button' name='submit' type='submit' value='Submit' />"+
    	"\n<input class='button' name='reset' type='reset' value='Reset' />"+
    	"\n</form>"+
    	"<script type='text/javascript'>setTimeout(function(){fetchNewChatData();}, 3000);</script>"+
    	"\n</body>"+
    	"\n</html>");
    response.end();
}).listen(8085);

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
