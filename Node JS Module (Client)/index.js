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
var currentDB = "bixeby";
var currentHost = "localhost";
var dbuser = "root";
var dbpass = "";
var mysql = require('mysql');

function submitToDB(post, dbName, tableName) {
	var connection = mysql.createConnection({
		host     : currentHost,
		user     : dbuser,
		password : dbpass,
		database : currentDB,
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

function queryDB(query) {
	var connection = mysql.createConnection({
		host     : currentHost,
		user     : dbuser,
		password : dbpass,
		database : currentDB,
	});
	connection.connect(function(err) {if(err){console.log(err);}});
	connection.query(query, function(err, rows, fields){});
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
		res.write("<li><a href='/user/?id="+sess.cid+"'>User Details</a></li>");
		res.write("<li><a href='/services'>Find an Appointment</a></li>");
		res.write("<li><a href='/appointments'>My Appointments</a></li>");
		//res.write("<li><a href='/contacts'>Contacts</a></li>");
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
		host     : currentHost,
		user     : dbuser,
		password : dbpass,
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

// User Profile View
app.get('/user',function(req,res){
	sess = req.session;
	var url = require("url");
    var params = url.parse(req.url, true).query;
   	var pageOwner = params.id;
   	var action = params.action;

	var connection = mysql.createConnection({
		host     : currentHost,
		user     : dbuser,
		password : dbpass,
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
	} else if(action == 'update') {

		var first_name = params.first_name;
		var last_name = params.last_name;
		var birthdate = params.birthdate;
		var contactno = params.contactno;
		var address = params.address;
		var email = params.email;
		var post = {first_name, last_name, birthdate, contactno, address, email};
		console.log(post);
		queryDB("UPDATE clients set first_name='"+first_name+
			"', last_name='"+last_name+"', birthdate='"+birthdate+"', contactno='"+contactno+"', address='"+address+
			"', email='"+email+"' where clientno='"+sess.cid+"'", function(err, rows, fields){
		});
	res.redirect("user?id="+sess.cid);
	} else if(action == 'edit') {
		connection.query("SELECT * from clients where clientno='"+sess.cid+"'", function(err, rows, fields) {
			res.writeHead(200, {"Content-Type":"text/html"});
			res.write(`<html>
			<head>
				<title>Edit Details</title>
			</head>
			<body>
			<h1>Edit User Details</h1><form action='http://localhost:9000/user' target='_top' name='profile'>
			`);
			res.write("<label for='first_name'>First Name: <label><input name='first_name' type='text' value='"+rows[0].first_name+"' /><br>");
			res.write("<label for='last_name'>Last Name: <label><input name='last_name' type='text' value='"+rows[0].last_name+"' /><br>");
			res.write("<label for='birthdate'>Birthdate: <label><input name='birthdate' type='date' required /><br>");
			res.write("<label for='email'>Email: <label><input name='email' type='text' value='"+rows[0].email+"' required /><br>");
			res.write("<label for='contactNo'>Contact No.: <label><input name='contactno' type='text' value='"+rows[0].contactno+"' required /><br>");
			res.write("<label for='address'>Address*: <label><input name='address' type='text' value='"+rows[0].address+"' required default='' /><br>");
			res.write(`
		   	<input name='action' type='hidden' value='update' />
		   	<input name='submit' type='submit' value='Submit' />
		   	</form>
			</body>
			</html>`);
		    
			res.end();
		});
		connection.end(function(){});
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
		    	res.write("\n<h2>Personal Details [<a href='/user?action=edit'>Edit</a>]</h2>");
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


var alreadyInContact = false;
function foundResult(res) {
	alreadyInContact = res;
}

function contactAdding(uid, spid) {
	var connection = mysql.createConnection({
		host     : currentHost,
		user     : dbuser,
		password : dbpass,
		database : currentDB,
	});
	connection.connect(function(err) {
	    	// in case of error
		if(err){
		    console.log(err);
		}
	});
	//var resz = "";
	connection.query("SELECT * from contact_relation where clientno='"+uid+"' and spid='"+spid+"'", function(err, rows, fields) {
		if(err || rows <= 0) {
			//res.writeHead(200, {"Content-Type":"text/html"});
			console.log("fail");
			foundResult(false)
		} else {
			foundResult(true);
		}
	});

	connection.end(function(){});
}


// Provider Profile View
app.get('/provider',function(req,res){
	sess = req.session;
	var url = require("url");
    var params = url.parse(req.url, true).query;
   	var spid = params.id;

	var connection = mysql.createConnection({
		host     : currentHost,
		user     : dbuser,
		password : dbpass,
		database : currentDB,
	});
	connection.connect(function(err) {
	    	// in case of error
		if(err){
		    console.log(err);
		}
	});
	contactAdding(sess.cid, spid);
	if(!sess.username) {
		res.render("loginrequired.html");
	} else {
		connection.query("SELECT serviceproviders.*, sp_skills.*, services.* from serviceproviders inner join sp_skills on serviceproviders.spid = sp_skills.spid inner join services on sp_skills.serviceid = services.serviceid where serviceproviders.spid='"+spid+"'", function(err, rows, fields) {
		    res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html>\n<head>\n<title>Provider Profile</title>");
			res.write("\n<html>\n<head>");
			res.write("\n<body>");
		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>Provider was not found.</h1>");
		    } else { // profile is found

		    	if(alreadyInContact) {
		    		console.log("Already in Contacts");
		    		res.write("<a href='/chat?receiver="+rows[0].username+"'>Send a Message</a>");
		    	} else {
		    		res.write("<a href='/addcontact?id="+spid+"'>Add to Contacts</a>");
		    	}

		    	res.write("\n<h1>"+rows[0].first_name+" "+rows[0].last_name+"</h1>");
		    	res.write("\n<h2>Service Rating: "+rows[0].totalrating+"</h2>");
		    	res.write("\n<h2>Skills</h2>");
				res.write("\n<ul>");

				for(s = 0; s < rows.length; s++) {
					res.write("\n<li><a href='/service/?id="+rows[s].serviceid+"'>" + rows[s].servicename + "</a></li>");
				}

				res.write("\n</ul>");
				res.write("\n<a href='/home'>Home</a>");
		    }
		    res.write("\n</body>\n</html>");
			res.end();
		});
		connection.end(function(){});
	} 
});

// Contacts
app.get('/contacts',function(req,res){
	sess = req.session;

	if(!sess.username) {
		res.render("loginrequired.html");
	} else {

		var connection = mysql.createConnection({
			host     : currentHost,
			user     : dbuser,
			password : dbpass,
			database : currentDB,
		});
		connection.connect(function(err) {
		    	// in case of error
			if(err){
			    console.log(err);
			}
		});
		//var resz = "";

		connection.query("SELECT DISTINCT contact_relation.spid, concat(serviceproviders.first_name, ' ', serviceproviders.last_name) as name from contact_relation inner join serviceproviders on contact_relation.spid = serviceproviders.spid where clientno='"+sess.cid+"'", function(err, rows, fields) {
			res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html>\n<head>\n<title>User Contacts</title>");
			res.write("\n<html>\n<head>");
			res.write("\n<body>");
			//console.log(rows);
		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>User was not found!</h1>");
		    } else {
				res.write("\n<h1>Contact List</h1>");
				res.write("\n<ul>");
		    	for(g = 0; g < rows.length; g++) {
					res.write("\n<li><a href='/provider?id="+rows[g].spid+"'>"+rows[g].name+"</li>");
		    	}
				res.write("\n</ul>");
		    }
		    res.write("\n</body>");
			res.write("\n</html>");
			res.end();
		});

		connection.end(function(){});
	} 
});

// Add Provider as Contact
app.get('/addcontact',function(req,res){
	sess = req.session;
	var url = require("url");
    var params = url.parse(req.url, true).query;
   	var spid = params.id;

	if(!sess.username) {
		res.render("loginrequired.html");
	} else {
		var clientno = sess.cid;
		var post = {spid, clientno};
		submitToDB(post, currentDB, "contact_relation");
		//res.redirect("/provider?id="+spid);
		contactAdding(sess.cid, spid);
		res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html>\n<head>\n<title>Provider Profile</title>");
			res.write("\n<html>\n<head>");
			res.write("\n<body><h1>Successfully added!</h1><a href='/provider?id="+spid+"'>Go back</a>");
			res.write("\n</body>");
			res.write("\n</html>");
		res.end();
	} 
});


// Appointments
app.get('/appointments',function(req,res){
	sess = req.session;

	if(!sess.username) {
		res.render("loginrequired.html");
	} else {

		var connection = mysql.createConnection({
			host     : currentHost,
			user     : dbuser,
			password : dbpass,
			database : currentDB,
		});
		connection.connect(function(err) {
		    	// in case of error
			if(err){
			    console.log(err);
			}
		});

		connection.query("SELECT *  from appointments inner join serviceprovider_schedules on appointments.sp_schedid = serviceprovider_schedules.schedid inner join clients on appointments.clientno = clients.clientno inner join serviceproviders on serviceprovider_schedules.spid = serviceproviders.spid inner join services on appointments.serviceid = services.serviceid where appointments.clientno='"+sess.cid+"'", function(err, rows, fields) {
			res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html>\n<head>\n<title>User Appointments</title>");
			res.write("\n<html>\n<head>");
			res.write("\n<body>");
			//console.log(rows);
		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>No Apponintments at this time</h1>");
		    } else {


				res.write("\n<h1>Ongoing Appointments</h1>");

		    	for(g = 0; g < rows.length; g++) {
		    		if(rows[g].status == 'accepted') {
						res.write("\n<ul>");
						res.write("\n<li>Date: "+rows[g].start_time+"-"+rows[g].end_time+" " + rows[g].day_available + "</li>");
						res.write("\n<li>Service: "+rows[g].servicename+ "</li>");
						res.write("\n<li>Price: "+rows[g].serviceamount+ "</li>");
						res.write("\n<li>Location: "+rows[g].address+ "</li>");
						res.write("\n<li>Service Provider: "+rows[g].first_name+ " " + rows[g].last_name + "</li>");
						res.write("\n<li> &nbsp; </li>");
		    			res.write("\n</ul>");
		    		}
		    	}

		    	res.write("\n<hr />");
				res.write("\n<h1>Sent Requests</h1>");

		    	for(g = 0; g < rows.length; g++) {
		    		if(rows[g].status == 'request') {
		    			res.write("\n<ul>");
						res.write("\n<li>Date: "+rows[g].start_time+"-"+rows[g].end_time+" " + rows[g].day_available + "</li>");
						res.write("\n<li>Service: "+rows[g].servicename+ "</li>");
						res.write("\n<li>Price: "+rows[g].serviceamount+ "</li>");
						res.write("\n<li>Location: "+rows[g].address+ "</li>");
						res.write("\n<li>Service Provider: "+rows[g].first_name+ " " + rows[g].last_name + "</li>");
						res.write("\n<li><a href='/schedule?action=cancel&no="+rows[g].appointmentno+"'>Cancel</a></li>");
						res.write("\n</ul>");
		    		}
		    	}

		    }
		    res.write("\n</body>");
			res.write("\n</html>");
			res.end();
		});

		connection.end(function(){});
	} 
});

// Schedule 
app.get('/schedule',function(req,res){
	sess = req.session;
	var url = require("url");
    var params = url.parse(req.url, true).query;
   	var sp_schedid = params.take;
   	var serviceid = params.serviceid;
   	var clientno = sess.cid;
   	var action = params.action;
   	var appointmentno = params.no;

	if(!sess.username) {
		res.render("loginrequired.html");
	} else if(action == 'cancel') {
		var connection = mysql.createConnection({
			host     : currentHost,
			user     : dbuser,
			password : dbpass,
			database : currentDB,
		});
		connection.connect(function(err) {if(err){console.log(err);}});
		connection.query("select * from appointments where appointments.appointmentno = '"+appointmentno+"'", function(err, rows, fields) {
			if(err){
				console.log(err);
			} else if(rows[0].status == 'accepted') {
				res.write("<h1>Request cannot be cancelled.</h1>");
				res.write("<a href='/appointments'>Appointments</a><br>");
				res.write("<a href='/home'>Home</a>");
			} else {
				queryDB("DELETE FROM appointments WHERE appointments.appointmentno = '"+appointmentno+"' and status = 'request'");
				res.write("<h1>Request has been cancelled.</h1>");
				res.write("<a href='/appointments'>Appointments</a><br>");
				res.write("<a href='/home'>Home</a>");
			}
			res.end();

		});

		connection.end();

	} else  {
		var connection = mysql.createConnection({
			host     : currentHost,
			user     : dbuser,
			password : dbpass,
			database : currentDB,
		});
		connection.connect(function(err) {if(err){console.log(err);}});
		connection.query("select * FROM appointments WHERE sp_schedid = '"+sp_schedid+"' order by status desc", function(err, rows, fields) {
			console.log(rows);

			if(!err) {
				if(rows.length > 0 && rows[0].status == 'accepted' && rows[0].sp_schedid == sp_schedid){
					res.write("<h1>Sorry that schedule is already taken.</h1>");
				} else {
					var post = {sp_schedid, clientno, serviceid};
					submitToDB(post, currentDB, "appointments");
					console.log(post);
					res.write("<h1>The request has been sent. Please wait for confirmation.</h1>");
					res.write("<a href='/home'>Home</a>");
				}
			} else {
					res.write("<h1>Cannot process your request at this time.</h1>");
			}

			res.end();

		});
		connection.end();
	} 
});


// Search
app.get('/search',function(req,res){
	sess = req.session;
	var url = require("url");
    var params = url.parse(req.url, true).query;
   	var category = params.category;
   	var action = params.action;
   	var period = params.period;
   	var serviceid = params.serviceid;
   	var day = params.day_available;
   	var sign = "";

   	//console.log(day);

   	switch(period) {
   		case 'morning':
   		 sign = " < ";
   		 break;
   		case 'afternoon':
   		 sign = " > ";
   		 break;
   	}

   	if(sess.username && action == 'find') {
		res.writeHead(200, {"Content-Type":"text/html"});
		var connection = mysql.createConnection({
				host     : currentHost,
				user     : dbuser,
				password : dbpass,
				database : currentDB,
		});
		connection.connect(function(err) {if(err){ console.log(err); }});
		connection.query("SELECT schedid, first_name, last_name, totalrating, start_time, end_time, sched_date, services.serviceid FROM serviceproviders join serviceprovider_schedules on serviceproviders.spid = serviceprovider_schedules.spid join sp_skills on serviceproviders.spid = sp_skills.spid join services on sp_skills.serviceid = services.serviceid where vacant = 'yes' and sched_date='"+day+"' and services.serviceid = '"+serviceid+"' and start_time "+sign+" '12:00:00'", function(err, rows, fields) {
		    if(err || rows.length <= 0) {
		    	res.end("\n<h1>No one is available at this schedule.</h1>");
		    } else {
		    	res.write("<h3>Available Service Providers</h3>");
		    	for(r = 0; r < rows.length; r++){
		    		res.write("<ul>");
		    		res.write("<li>Service Provider: " + rows[r].first_name + " " + rows[r].last_name + "</li>");
		    		res.write("<li>Rating: " + rows[r].totalrating + "</li>");
		    		res.write("<li>Available during: " + rows[r].start_time + " - " + rows[r].end_time + "</li>");
		    		res.write("<li> <a href='/schedule?take="+rows[r].schedid+"&serviceid="+rows[r].serviceid+"'>Request this Appointment</a>");
		    		res.write("</ul>");
		    	}
		    	res.end();
		    }

		});
		connection.end(function(){});

   	} else if(sess.username) { // already logged in
		var connection = mysql.createConnection({
				host     : currentHost,
				user     : dbuser,
				password : dbpass,
				database : currentDB,
		});
		res.writeHead(200, {"Content-Type":"text/html"});
		connection.connect(function(err) {if(err){ console.log(err); }});
		connection.query("SELECT * from services where category='"+category+"' order by serviceid", function(err, rows, fields) {
		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>No categories are available right now.</h1>");
		    } else {
				res.write("<html><head><title>BxB Services</title>");
				res.write("<script type='text/javascript' src='jquery-3.1.1.min.js'></script>");
				res.write("<script type='text/javascript' src='search.js'></script>");
				res.write("</head><body>");
		    	res.write("\n<h1>"+category.toUpperCase()+" Services</h1>");
		    	res.write("\n<h2>Choose a Service</h2>");
				res.write("<select name='service' id='service'>");
		    	for(c = 0; c < rows.length; c++) {
		    		res.write("<option value='"+rows[c].serviceid+"'>"+rows[c].servicename + "</option>");
		    	}
				res.write("</select>");

				res.write("<hr />");
		    	res.write("\n<h1>Find an available Service Provider</h2>");
		    	res.write("\n<h2>Choose an appointment day</h2>");
		    	/*var days = ['sun','mon','tue','wed','thu','fri','sat'];
				res.write("<select name='day' id='day'>");
		    	for(d = 0; d < days.length; d++) {
		    		res.write("<option value='"+days[d]+"'>"+ days[d] + "</option>");
		    	}*/
		    	res.write("<input type='date' id='day' name='day' />");
				//res.write("</select>");

		    	res.write("\n<h2>Choose a time period</h2>");
				res.write("<select name='period' id='period'>");
		    	res.write("<option value='morning'>7am to 12 noon</option>");
		    	res.write("<option value='afternoon'>12 noon to 6pm</option>");
				res.write("</select>");
				res.write("<input type='button' name='find' id='find' value='Find'>");

				res.write("<div id='result'></div>");
				res.write("<br><br><br><br><a href='/services'>Other Categories</a>");
				res.end("</body></html>");

		    }
		});
		connection.end(function(){});			

    } else {
		res.render("loginrequired.html");
		res.end();
		return false;
  	}
});

// Services View
app.get('/services',function(req,res){
	sess = req.session;

	//var url = require("url");
    //var params = url.parse(req.url, true).query;
    //var action = params.category;

 	if(sess.username) { // already logged in
		var connection = mysql.createConnection({
				host     : currentHost,
				user     : dbuser,
				password : dbpass,
				database : currentDB,
		});
		connection.connect(function(err) {
			if(err){ console.log(err); }
		});
		connection.query("SELECT distinct category from services", function(err, rows, fields) {
			res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html><head><title>BxB Services</title></head><body>");
			res.write("<h1>What do you need?</h1>");
		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>No services are available right now.</h1>");
		    } else {
				res.write("<ul>");
		    	for(c = 0; c < rows.length; c++) {
		    		res.write("<li><a href='/search?category="+rows[c].category+"'>" + rows[c].category + "</a></li>");
		    	}
				res.write("</ul>");	
		    }
			res.write("</body></html>");
	  		res.end();
		});
		connection.end(function(){});

    } else {
		res.render("loginrequired.html");
		res.end();
		return false;
  }

});

// Category View
app.get('/category', function(req,res){
	sess = req.session;

	var url = require("url");
    var params = url.parse(req.url, true).query;
    var category = params.name;

 	if(sess.username) { // already logged in
		var connection = mysql.createConnection({
				host     : currentHost,
				user     : dbuser,
				password : dbpass,
				database : currentDB,
		});
		connection.connect(function(err) {
			if(err){ console.log(err); }
		});
		connection.query("SELECT serviceid, servicename from services where category='"+category+"'", function(err, rows, fields) {
			res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html><head><title>BxB " + category + " Service</title></head><body>");
			res.write("<h1>" + category + " Services</h1>");

		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>No services are available right now.</h1>");
		    } else {
				res.write("<ul>");
		    	for(c = 0; c < rows.length; c++) {
		    		res.write("<li><a href='/service/?id="+rows[c].serviceid+"'>" + rows[c].servicename + "</a></li>");
		    	}
				res.write("</ul>");	
		    }

			res.write("</body></html>");
	  		res.end();
		});
		connection.end(function(){});

    } else {
		res.render("loginrequired.html");
		res.end();
		return false;
  }

});

// Service View
app.get('/service', function(req,res){
	sess = req.session;

	var url = require("url");
    var params = url.parse(req.url, true).query;
    var id = params.id;

 	if(sess.username) { // already logged in
		var connection = mysql.createConnection({
				host     : currentHost,
				user     : dbuser,
				password : dbpass,
				database : currentDB,
		});
		connection.connect(function(err) {
			if(err){ console.log(err); }
		});


		// list of sps
		connection.query("select services.description, serviceproviders.spid, services.serviceid, services.servicename, concat(serviceproviders.first_name, ' ', serviceproviders.last_name) as spname from services inner join sp_skills on services.serviceid = sp_skills.serviceid inner join serviceproviders on sp_skills.spid = serviceproviders.spid where services.serviceid='"+id+"' order by serviceproviders.spid", function(err, rows, fields) {
			res.writeHead(200, {"Content-Type":"text/html"});
			res.write("<html><head><title>BxB Service Details</title></head><body>");
		    if(err || rows.length <= 0) {
		    	res.write("\n<h1>No services are available right now.</h1>");
		    	console.log(err);
		    } else {
		    	res.write("<h1>" + rows[0].servicename + " Service Details</h1>");
		    	res.write("<p>" + rows[0].description + "</p>");
				res.write("<h2>Available Service Providers</h2>");
		    	for(c = 0; c < rows.length; c++) {
		    		res.write("<li><a href='/provider/?id="+rows[c].spid+"'>" + rows[c].spname + "</a></li>");
		    	}
		    }

			res.write("</body></html>");
	  		res.end();
		});
		connection.end(function(){});

    } else {
		res.render("loginrequired.html");
		res.end();
		return false;
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
			host     : currentHost,
			user     : dbuser,
			password : dbpass,
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

  			var connection = mysql.createConnection({
			host     : currentHost,
			user     : dbuser,
			password : dbpass,
			database : currentDB,
		});
		connection.connect(function(err) {
		    // in case of error
			if(err){
			    console.log(err);
			}
		});
		//var result = "";
		connection.query("SELECT username from serviceproviders where username='"+receiver+"'", function(err, rows, fields) {
				var sender_username = sess.username;
		    	var message = params.msg;
		    	var client_username = sess.username;
		    	var sp_username = receiver;
				var post = {sender_username, message, client_username, sp_username};
				submitToDB(post, currentDB, "messages");
				res.writeHead(200, {"Content-Type":"text/html"});
				res.write("<html><head><title>Message Sent</title></head><body></body></html>");
		    	res.end();
		});
		connection.end(function(){});
  	} else {
		res.render("loginrequired.html");
		res.end();
		//return false;
  	}

});