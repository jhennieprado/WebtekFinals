var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var app = express();

app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);

app.use(session({secret: 'xxx'}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static('views'));

var sess;
var port = process.argv[2];
var currentDB = "bxb";
var mysql = require('mysql');

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
	connection.query('INSERT INTO '+tableName+' SET ?', post, function(err, result) {
		if(err){
		    console.log("Insert error: " + err);
		}
	});
	// the connection has been closed
	connection.end(function(){});
}

const http = require('http');
const url = require('url');
const fs = require('fs');
const path = require('path');

// assign port
app.listen(port,function(){
	console.log("App Started on PORT " + port);
});

// Redirect to login | Home page
app.get('/',function(req,res){
	res.redirect("/home");
});

// login | Home page
app.get('/home',function(req,res){
	sess = req.session;

	var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;

	//console.log("action " + action);

 	if(sess.username && action != "logout") { // already logged in
	 	res.writeHead(200, {"Content-Type":"text/html"});
		res.write("<html><head><title>BxB Home</title></head><body>");
		res.write("<h1>*Homepage*</h1>");
		res.write("<ul>");
		res.write("<li><a href='/user/?id="+sess.cid+"'>My Profile</a></li>");
		res.write("<li><a href='/chat/?receiver=AWDAWD'>Chatbox (sample: user1 as receiver)</a></li>");
		res.write("<li><a href='/chat/?receiver=user2'>Chatbox (sample: user2 as receiver)</a></li>");
		res.write("<li><a href='/home/?action=logout'>Log out</a></li>");
		res.write("</ul>");	
		res.write("</body></html>");
  		res.end();
    } else if(action == "logout"){
		req.session.destroy(function(err) {
		  if(err) {
		    console.log(err);
		  } else {
		  	console.log("Logged out!");
		    res.redirect('/home');
		  }
		});
    } else {
		res.render("login.html");
		res.end();
		return false;
  }

});

// login Submission
app.post('/login',function(req,res){
	sess = req.session;

	sess.username = req.body.username;
	sess.password = req.body.password;

	// console.log(sess.username);
	var connection = mysql.createConnection({
		host     : 'localhost',
		user     : 'root',
		password : '',
		database : currentDB,
	});
	connection.connect(function(err) {
	    // in case of error
		if(err){
		    console.log(err);
		}
	});
	connection.query("SELECT * from clients where (username='"+sess.username+"' and password='"+sess.password+"')", 
	function(err, rows, fields) {
	    if(err){console.log(err);return;}
		    if(rows.length == 1) { // match
	    		console.log(sess.username +" has successfully logged in!"); // what to do?
				sess = req.session;
				sess.username = req.body.username;
				sess.cid = rows[0].clientno;
				res.end("done");
		    } else {
				req.session.destroy(function(err) {
				  if(err) {
				    console.log(err);
				  } else {
				  	console.log("Failed login!");
				    res.end("fail");
				  }
				});
		    	return false;
	    	}
	});
	connection.end(function(){});
});


// Registration
app.get('/register',function(req,res){
	sess = req.session;

	var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;

 	if(!sess.username && !params.action) { // not logged in
		res.render("registration/registration.html");
    } else if(!sess.username && action == "submit"){

		var username = params.username;
		var first_name = params.first_name;
		var last_name = params.last_name;
		var birthdate = params.birthdate;
		var password = params.password;
		var contactno = params.contactno;
		var address = params.address;
		var email = params.email;
		var post = {username, first_name, last_name, birthdate, password, contactno, address, email};

		submitToDB(post, currentDB, "clients");

    	res.redirect("registration/submitted.html");
    } else if(sess.username){
    	res.redirect("/home");
  	}

});


// Profile
app.get('/user',function(req,res){
	sess = req.session;
	var url = require("url");
    var params = url.parse(req.url, true).query;
   	var pageOwner = params.id;

	var connection = mysql.createConnection({
		host     : 'localhost',
		user     : 'root',
		password : '',
		database : currentDB,
	});
	connection.connect(function(err) {
	    	// in case of error
		if(err){
		    console.log(err);
		}
	});
	if(!sess.username) {
		res.render("loginrequired.html");
	} else if(sess.cid == pageOwner) {
		connection.query("SELECT * from clients where clientno='"+sess.cid+"'", function(err, rows, fields) {
			res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html>\n<head>\n<title>User Profile</title>");
			res.write("\n<html>\n<head>");
			res.write("\n<body>");
			console.log(rows);
		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>User was not found! cid error</h1>");
		    } else if(sess.cid == rows[0].clientno){ // user is viewing his/her profile
		    	res.write("\n<h1>"+rows[0].first_name+" "+rows[0].last_name+" ("+sess.username+") </h1>");
		    	res.write("\n<h2>Personal Details</h2>");
				res.write("\n<ul>");
				res.write("\n<li>Member Since: "+new String(rows[0].accountcreated).slice(3, 15)+"</li>");
				res.write("\n<li>Birthdate: "+new String(rows[0].birthdate).slice(3, 15)+"</li>");
				res.write("\n<li>Email: "+rows[0].email+"</li>");
				res.write("\n<li>Contact No.: "+rows[0].contactno+"</li>");
				res.write("\n<li>Address: "+rows[0].address+"</li>");
				var status = "";
				if(rows[0].accepted == "Y") {
					status = "Verified";
				} else {
					status = "Pending";
				}
				res.write("\n<li>Account Status: "+status+"</li>");
				res.write("\n</ul>");
				res.write("\n<a href='/home'>Home</a>");
				
		    }
		    res.write("\n</body>\n</html>");
			res.end();
		});
		connection.end(function(){});
	} else { // other users viewing another's profile
		connection.query("SELECT first_name, last_name, accountcreated, birthdate, accepted from clients where clientno='"+pageOwner+"'", function(err, rows, fields) {
			res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html>\n<head>\n<title>User Profile</title>");
			res.write("\n<html>\n<head>");
			res.write("\n<body>");
			console.log(rows);
		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>User was not found!</h1>");
		    } else { //if(loggedUser == rows[0].username){ // user is viewing his/her profile
		    	res.write("\n<h1>"+rows[0].first_name+" "+rows[0].last_name+"'s Profile</h1>");
		    	res.write("\n<h2>Personal Details</h2>");
				res.write("\n<ul>");
				res.write("\n<li>Member Since: "+new String(rows[0].accountcreated).slice(3, 15)+"</li>");
				res.write("\n<li>Birthdate: "+new String(rows[0].birthdate).slice(3, 15)+"</li>");
				//res.write("\n<li>Email: "+rows[0].email+"</li>");
				//res.write("\n<li>Contact No.: "+rows[0].contactNo+"</li>");
				//res.write("\n<li>Address: "+rows[0].address+"</li>");
				var status = "";
				if(rows[0].accepted == "Y") {
					status = "Verified";
				} else {
					status = "Pending";
				}
				res.write("\n<li>Account Status: "+status+"</li>");
				res.write("\n</ul>");
		    }
		    res.write("\n</body>\n</html>");
			res.end();
		});
		connection.end(function(){});
	}
});



// Chatbox
app.get('/chat',function(req,res){
	sess = req.session;
	var url = require("url");
    var params = url.parse(req.url, true).query;
    var receiver = params.receiver;

	//console.log("action " + action);

 	if(sess.username && params.view != "display" && params.view != "submit") { //Logged in
		res.writeHead(200, {"Content-Type":"text/html"});
   		res.write("<html>"+
    	"\n<head>\n<title>Chatbox Form</title>"+
    	"\n<link rel='stylesheet' type='text/css' href='http://localhost:9000/chat/chat-style.css' />"+
    	"\n<script type='text/javascript' src='http://localhost:9000/chat/chat-script.js'></script>"+
    	"\n<script type='text/javascript'>\nvar loggedUser=\""+sess.username+"\";\nvar receiver=\""+receiver+"\";\n</script>"+
    	"\n</head>"+
    	"\n<body>");
    	res.write("\n<h1>Chatting with "+params.receiver+"</h1>"+
    	"\n<iframe name='chatsubmit' id='chatsubmit' src='#' style='display: none;'></iframe>"+
    	"\n<form id='chatbox' action='http://localhost:9000/chat' target='chatsubmit' name='chatbox'>"+
    	"\n<iframe id='msgbox' src='http://localhost:9000/chat?view=display&receiver="+receiver+"'></iframe></div>"+
	    "\n<input name='sender' type='hidden' value='" + sess.username +"' required />"+
	    "\n<label for='msg'>Message: </label><textarea class='text' name='msg'></textarea>"+
	    "\n<input name='receiver' type='hidden' value='"+receiver+"' />"+
	    "\n<input name='view' type='hidden' value='submit' />"+
	    "\n<input class='button' type='submit' value='Submit' />"+
	    "\n<input class='button'  type='reset' value='Reset' />"+
	    "\n</form>"+
	    "\n<script type='text/javascript'>setTimeout(function(){fetchNewChatData();}, 3000);</script>");
		res.write("<a href='http://localhost:9000/home'>Home</a>");
	    res.write("\n</body>"+"\n</html>");
  		res.end();
    } else if(params.view == "display") {
		var connection = mysql.createConnection({
			host     : 'localhost',
			user     : 'root',
			password : '',
			database : currentDB,
		});
		connection.connect(function(err) {
		    // in case of error
			if(err){
			    console.log(err);
			}
		});
		//var result = "";
		connection.query("SELECT * from messages where (client_username='"+sess.username+"' and sp_username='"+receiver+"')" +
			"order by timestamp limit 10", function(err, rows, fields) {
		    if(err){
		        console.log(err);
		        return;
		    }

		    res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html><head><title>Messages</title>");
			res.write("<script type='text/javascript'>setTimeout(function() {window.location.reload();}, 5000);</script>");
			res.write("<link rel='stylesheet' type='text/css' href='http://localhost:9000/chat/chat-style.css' />");
			res.write("</head><body>");
		    for(r = 0; r < rows.length; r++) {
		    	//console.log(typeof rows.sender);
		    	if(sess.username == rows[r].sender_username) { // your sent-messages [client]
					res.write("\n<span class='sent'><span class='receiver'>"+sess.username+"</span>");
					res.write("\n<span class='sent_message'>"+rows[r].message+"</span></span>");
		    	} else { // what you received
					res.write("\n<span class='received'><span class='sender'>"+receiver+"</span>");
					res.write("\n<span class='received_message'>"+rows[r].message+"</span></span>");
		    	}
		    }
			res.write("\n</body></html>");
			res.end();
		});
  	} else if(params.view == "submit") {
	    var sender_username = sess.username;
	    var message = params.msg;
	    var client_username = sess.username;
	    var sp_username = receiver;
		var post = {sender_username, message, client_username, sp_username};

		submitToDB(post, currentDB, "messages");

		res.writeHead(200, {"Content-Type":"text/html"});
		res.write("<html><head><title>Message Sent</title></head><body></body></html>");
	    res.end();
  	} else {
		res.render("loginrequired.html");
		res.end();
		//return false;
  	}

});