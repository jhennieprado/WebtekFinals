var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var app = express();

app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);

app.use(session({
    secret: 'xxx'
}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(express.static('views'));

var sess;
var port = process.argv[2];
var currentDB = "bxbfin";
var currentHost = "localhost";
var dbuser = "root";
var dbpass = "";
var mysql = require('mysql');

function submitToDB(post, dbName, tableName) {
    var connection = mysql.createConnection({
        host: currentHost,
        user: dbuser,
        password: dbpass,
        database: currentDB,
    });
    connection.connect(function(err) {
        // in case of error
        if (err) {
            console.log(err);
        }
    });
    // submit the data
    connection.query('INSERT INTO ' + tableName + ' SET ?', post, function(err, result) {
        if (err) {
            console.log("Insert error: " + err);
        }
    });
    // the connection has been closed
    connection.end(function() {});
}

function queryDB(query) {
    var connection = mysql.createConnection({
        host: currentHost,
        user: dbuser,
        password: dbpass,
        database: currentDB,
    });
    connection.connect(function(err) {
        if (err) {
            console.log(err);
        }
    });
    connection.query(query, function(err, rows, fields) {});
    connection.end(function() {});
}

const http = require('http');
const url = require('url');
const fs = require('fs');
const path = require('path');

// assign port
app.listen(port, function() {
    console.log("App Started on PORT " + port);
});

// Redirect to login | Home page
app.get('/', function(req, res) {
    res.redirect("/home");
});

app.get('/transactions', function(req, res) {


  sess = req.session;

    var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;

    if(!sess.username) {
        res.render("loginrequired.html");
    } else if(action == 'fetch') {
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query(`Select * from appointments 
            join serviceprovider_schedules on appointments.sp_schedid = serviceprovider_schedules.schedid
            join serviceproviders on serviceprovider_schedules.spid = serviceproviders.spid
            join services on appointments.serviceid = services.serviceid
            where clientno = '` + sess.cid + `' and status = 'done'`, function(err, rows, fields) {

            //try {
                if(rows.length != 0 | !err) {
                   for(i = 0; i < rows.length; i++){
                        // 
                        
                      res.write(` <div class="columns large-6 text-center"><ul class="no-bullet">
                      <li>
                      <span>`+rows[i].amount+` Pesos</span><br>
                      <span>Service</span> <br>
                      <span>`+new String(rows[i].sched_date).slice(0, 15) + ` ` + 
                                 new String(rows[i].start_time).slice(0, 5) + ` - ` +  
                                 new String(rows[i].end_time).slice(0, 5)+`</span><br>
                      </li>
                      </ul></div>`);
                      //res.write(rows[i].sched_date + "");
                   }
                } else {
                    res.write("<h1>You have no transactions.</h1>");
                }
            //} catch(e) {
             //   res.write("<h1>An error has occured!</h1>");
              //  res.write(e+"");
            //}

           res.end();
        });

        connection.end();
    } else {
        res.render("transactions.html");
    }

});

// login | Home page
app.get('/home', function(req, res) {
    sess = req.session;

    var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;

    if (sess.username && action != "logout") { // already logged in

        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query(`Select * from clients 
			
			where clients.clientno = '` + sess.cid + `'`, function(err, rows, fields) {
            /*join appointments on clients.clientno = appointments.clientno 
			join services on appointments.serviceid = services.serviceid
			join serviceprovider_schedules on appointments.sp_schedid = serviceprovider_schedules.schedid*/
            console.log(rows);
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            // doctype to body
            res.write(`<!doctype html><html class="no-js" lang="en" dir="ltr"> <head> <meta charset="utf-8"> <meta http-equiv="x-ua-compatible" content="ie=edge"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Beauty x Beast</title> <link rel="stylesheet" href="css/foundation.css"> <link rel="stylesheet" href="css/app.css"> <script src="js/vendor/jquery.js"></script> <script src="js/vendor/what-input.js"></script> <script src="js/vendor/foundation.js"></script> <script src="js/app.js"></script> </head> <body>`);

            // nav
            res.write(` <nav class="top-bar"> <div class="top-bar-title"> <a href="/home"><img src="images/bxb.png"><strong>Beauty x Beast</strong></a> </div><div id="responsive-menu"> <div class="top-bar-right"> <ul class="menu dropdown" data-dropdown-menu> <li><a href="/home" class="current">Home</a></li><li><a href="/services">Services</a></li><li><a href='/transactions'>Transactions</a></li><li><a href="home/?action=logout">Logout</a></li></ul> </div></div></nav>`);

            // user details
            res.write(`<section  id="serviceProfHead"><div class="row align-middle"><div class="columns large-2"><img src="images/` + rows[0].profpic + `" onerror="this.src='images/default.png'"></div><div class="columns large-10">`);
            res.write("\n<span>" + rows[0].first_name + " " + rows[0].last_name + "</span><br>");
            res.write("\n<span><b>Member Since:</b> " + new String(rows[0].accountcreated).slice(3, 15) + "</span><br>");
            res.write("\n<span><b>Birthdate:</b> " + new String(rows[0].birthdate).slice(3, 15) + "</span><br>");
            res.write("\n<span id='email'><b>Email:</b> " + rows[0].email + " </span> <a href='#' onclick='editEmail();'><sup>Edit</sup></a><br>");
            res.write("\n<span id='contact'><b>Contact No.:</b> " + rows[0].contactno + "</span> <a href='#' onclick='editNum();'><sup>Edit</sup></a><br>");
            res.write("\n<span id='address'><b>Address:</b> " + rows[0].address + "</span> <a href='#' onclick='editAddress();'><sup>Edit</sup></a><br>");
            var status = "";
            if (rows[0].accepted == "Y") {
                status = "Verified";
            } else {
                status = "Pending";
            }
            res.write("\n<span><b>Account Status:</b> " + status + "</span><br>");
            res.write(`</div></div></section>`);

            // appointments
            res.write(` <main class="row" id="serviceProfDet"> <div class="columns large-7" > <span>My Appointments</span> <div class="row" data-equalizer> <div class="columns"> <div class="media-object"> <div class="media-object-section">`);

            res.write("<div id='ongoing'></div>");
            res.write("<div id='requests'></div>");
            res.write("<div id='done'></div>");

            // end of appointments
            res.write(`</div></div></div></div></div>`);

            //sidebar notifications
            res.write(` <div class="columns large-4 large-offset-1" id="profReview"></div></main>`);

            res.write(`<script src='appointments.js'></script>`);
            res.write(`<script src='notifications.js'></script>`);
            res.write(`<script src='rating.js'></script>`);
            res.write(`<script src='editinfo.js'></script>`);
            
            // footer - html
            res.write(` <footer> <div class="row"> <div class="columns large-12"> <span>&copy; 2017 Beauty x Beast Inc, All Rights Reserved</span> </div></div></footer> </body></html>`);

            res.end();
        });

        connection.end();



    } else if (action == "logout") {
        req.session.destroy(function(err) {
            if (err) {
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


/*
app.get('/appointments',function(req,res){
	sess = req.session;

	var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;

});*/


// login Submission
app.post('/login', function(req, res) {
    sess = req.session;

    sess.username = req.body.username;
    sess.password = req.body.password;

    // console.log(sess.username);
    var connection = mysql.createConnection({
        host: currentHost,
        user: dbuser,
        password: dbpass,
        database: currentDB,
    });
    connection.connect(function(err) {
        // in case of error
        if (err) {
            console.log(err);
        }
    });
    connection.query("SELECT * from clients where (username='" + sess.username + "' and password='" + sess.password + "' and accepted = 'Y')",
        function(err, rows, fields) {
            if (err) {
                console.log(err);
                return;
            }
            if (rows.length == 1) { // match

                if(rows[0].accepted == 'Y') {
                    sess = req.session;
                    sess.username = req.body.username;
                    sess.cid = rows[0].clientno;
                    res.end("done");
                } else {
                    res.end("unaccepted");
                }
            } else {
                req.session.destroy(function(err) {
                    if (err) {
                        console.log(err);
                    } else {
                        console.log("Failed login!");
                        res.end("fail");
                    }
                });
                return false;
            }
        });
    connection.end(function() {});
});


// Registration
app.get('/register', function(req, res) {
    sess = req.session;

    var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;

    if (!sess.username && !params.action) { // not logged in
        res.render("registration/registration.html");
    } else if (!sess.username && action == "submit") {

        var username = params.username;
        var first_name = params.first_name;
        var last_name = params.last_name;
        var birthdate = params.birthdate;
        var password = params.password;
        var contactno = params.contactno;
        var address = params.address;
        var email = params.email;
        var post = {
            username,
            first_name,
            last_name,
            birthdate,
            password,
            contactno,
            address,
            email
        };

        submitToDB(post, currentDB, "clients");

        res.redirect("registration/submitted.html");
    } else if (sess.username) {
        res.redirect("/home");
    }

});

// User Profile View
app.get('/user', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var pageOwner = params.id;
    var action = params.action;

    var connection = mysql.createConnection({
        host: currentHost,
        user: dbuser,
        password: dbpass,
        database: currentDB,
    });
    connection.connect(function(err) {
        // in case of error
        if (err) {
            console.log(err);
        }
    });
    if (!sess.username) {
        res.render("loginrequired.html");
    } else if (action == 'update') {

        var first_name = params.first_name;
        var last_name = params.last_name;
        var birthdate = params.birthdate;
        var contactno = params.contactno;
        var address = params.address;
        var email = params.email;
        var post = {
            first_name,
            last_name,
            birthdate,
            contactno,
            address,
            email
        };
        //console.log(post);
        queryDB("UPDATE clients set first_name='" + first_name +
            "', last_name='" + last_name + "', birthdate='" + birthdate + "', contactno='" + contactno + "', address='" + address +
            "', email='" + email + "' where clientno='" + sess.cid + "'",
            function(err, rows, fields) {});
        res.redirect("user?id=" + sess.cid);
    } else if (action == 'edit') {
        connection.query("SELECT * from clients where clientno='" + sess.cid + "'", function(err, rows, fields) {
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            res.write(`<html>
			<head>
				<title>Edit Details</title>
			</head>
			<body>
			<h1>Edit User Details</h1><form action='http://localhost:9000/user' target='_top' name='profile'>
			`);
            res.write("<label for='first_name'>First Name: <label><input name='first_name' type='text' value='" + rows[0].first_name + "' /><br>");
            res.write("<label for='last_name'>Last Name: <label><input name='last_name' type='text' value='" + rows[0].last_name + "' /><br>");
            res.write("<label for='birthdate'>Birthdate: <label><input name='birthdate' type='date' required /><br>");
            res.write("<label for='email'>Email: <label><input name='email' type='text' value='" + rows[0].email + "' required /><br>");
            res.write("<label for='contactNo'>Contact No.: <label><input name='contactno' type='text' value='" + rows[0].contactno + "' required /><br>");
            res.write("<label for='address'>Address*: <label><input name='address' type='text' value='" + rows[0].address + "' required default='' /><br>");
            res.write(`
		   	<input name='action' type='hidden' value='update' />
		   	<input name='submit' type='submit' value='Submit' />
		   	</form>
			</body>
			</html>`);

            res.end();
        });
        connection.end(function() {});
    } else {
        connection.query("SELECT * from clients where clientno='" + sess.cid + "'", function(err, rows, fields) {
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            res.write("<html>\n<head>\n<title>User Profile</title>");
            res.write("\n<html>\n<head>");
            res.write("\n<body>");
            //console.log(rows);
            if (err || rows.length <= 0) {
                res.write("\n<h1>User was not found! cid error</h1>");
            } else if (sess.cid == rows[0].clientno) { // user is viewing his/her profile
                res.write("\n<h1>" + rows[0].first_name + " " + rows[0].last_name + " (" + sess.username + ") </h1>");
                res.write("\n<h2>Personal Details [<a href='/user?action=edit'>Edit</a>]</h2>");
                res.write("\n<ul>");
                res.write("\n<li>Member Since: " + new String(rows[0].accountcreated).slice(3, 15) + "</li>");
                res.write("\n<li>Birthdate: " + new String(rows[0].birthdate).slice(3, 15) + "</li>");
                res.write("\n<li>Email: " + rows[0].email + "</li>");
                res.write("\n<li>Contact No.: " + rows[0].contactno + "</li>");
                res.write("\n<li>Address: " + rows[0].address + "</li>");
                var status = "";
                if (rows[0].accepted == "Y") {
                    status = "Verified";
                } else {
                    status = "Pending";
                }
                res.write("\n<li>Account Status: " + status + "</li>");
                res.write("\n</ul>");
                res.write("\n<a href='/home'>Home</a>");

            }
            res.write("\n</body>\n</html>");
            res.end();
        });
        connection.end(function() {});
    }
    /* else { // other users viewing another's profile
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
    	}*/
});


var alreadyInContact = false;

function foundResult(res) {
    alreadyInContact = res;
}

function contactAdding(uid, spid) {
    var connection = mysql.createConnection({
        host: currentHost,
        user: dbuser,
        password: dbpass,
        database: currentDB,
    });
    connection.connect(function(err) {
        // in case of error
        if (err) {
            console.log(err);
        }
    });
    //var resz = "";
    connection.query("SELECT * from contact_relation where clientno='" + uid + "' and spid='" + spid + "'", function(err, rows, fields) {
        if (err || rows <= 0) {
            //res.writeHead(200, {"Content-Type":"text/html"});
            //console.log("fail");
            foundResult(false)
        } else {
            foundResult(true);
        }
    });

    connection.end(function() {});
}


// Provider Profile View
app.get('/provider', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var spid = params.id;

    var connection = mysql.createConnection({
        host: currentHost,
        user: dbuser,
        password: dbpass,
        database: currentDB,
    });
    connection.connect(function(err) {
        // in case of error
        if (err) {
            console.log(err);
        }
    });
    contactAdding(sess.cid, spid);
    if (!sess.username) {
        res.render("loginrequired.html");
    } else {
        connection.query("SELECT serviceproviders.*, sp_skills.*, services.* from serviceproviders inner join sp_skills on serviceproviders.spid = sp_skills.spid inner join services on sp_skills.serviceid = services.serviceid where serviceproviders.spid='" + spid + "'", function(err, rows, fields) {
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            res.write("<html>\n<head>\n<title>Provider Profile</title>");
            res.write("\n<html>\n<head>");
            res.write("\n<body>");
            if (err || rows.length <= 0) {
                res.write("\n<h1>Provider was not found.</h1>");
            } else { // profile is found

                if (alreadyInContact) {
                    //console.log("Already in Contacts");
                    res.write("<a href='/chat?receiver=" + rows[0].username + "'>Send a Message</a>");
                } else {
                    res.write("<a href='/addcontact?id=" + spid + "'>Add to Contacts</a>");
                }

                res.write("\n<h1>" + rows[0].first_name + " " + rows[0].last_name + "</h1>");
                res.write("\n<h2>Service Rating: " + rows[0].totalrating + "</h2>");
                res.write("\n<h2>Skills</h2>");
                res.write("\n<ul>");

                for (s = 0; s < rows.length; s++) {
                    res.write("\n<li><a href='/service/?id=" + rows[s].serviceid + "'>" + rows[s].servicename + "</a></li>");
                }

                res.write("\n</ul>");
                res.write("\n<a href='/home'>Home</a>");
            }
            res.write("\n</body>\n</html>");
            res.end();
        });
        connection.end(function() {});
    }
});

// Contacts
app.get('/contacts', function(req, res) {
    sess = req.session;

    if (!sess.username) {
        res.render("loginrequired.html");
    } else {

        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            // in case of error
            if (err) {
                console.log(err);
            }
        });
        //var resz = "";

        connection.query("SELECT DISTINCT contact_relation.spid, concat(serviceproviders.first_name, ' ', serviceproviders.last_name) as name from contact_relation inner join serviceproviders on contact_relation.spid = serviceproviders.spid where clientno='" + sess.cid + "'", function(err, rows, fields) {
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            res.write("<html>\n<head>\n<title>User Contacts</title>");
            res.write("\n<html>\n<head>");
            res.write("\n<body>");
            //console.log(rows);
            if (err || rows.length <= 0) {
                res.write("\n<h1>User was not found!</h1>");
            } else {
                res.write("\n<h1>Contact List</h1>");
                res.write("\n<ul>");
                for (g = 0; g < rows.length; g++) {
                    res.write("\n<li><a href='/provider?id=" + rows[g].spid + "'>" + rows[g].name + "</li>");
                }
                res.write("\n</ul>");
            }
            res.write("\n</body>");
            res.write("\n</html>");
            res.end();
        });

        connection.end(function() {});
    }
});

// Add Provider as Contact
app.get('/addcontact', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var spid = params.id;

    if (!sess.username) {
        res.render("loginrequired.html");
    } else {
        var clientno = sess.cid;
        var post = {
            spid,
            clientno
        };
        submitToDB(post, currentDB, "contact_relation");
        //res.redirect("/provider?id="+spid);
        contactAdding(sess.cid, spid);
        res.writeHead(200, {
            "Content-Type": "text/html"
        });
        res.write("<html>\n<head>\n<title>Provider Profile</title>");
        res.write("\n<html>\n<head>");
        res.write("\n<body><h1>Successfully added!</h1><a href='/provider?id=" + spid + "'>Go back</a>");
        res.write("\n</body>");
        res.write("\n</html>");
        res.end();
    }
});









// Appointments
app.get('/notifications', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;

    if (!sess.username) {
        res.render("loginrequired.html");
    } else if (action == 'latest') {
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query(`SELECT *  from notify_client 
        	join appointments on notify_client.appointmentno = appointments.appointmentno
        	join services on appointments.serviceid = services.serviceid
        	join serviceprovider_schedules on appointments.sp_schedid = serviceprovider_schedules.schedid
 	        where receiver='` + sess.cid + `' and seen = 'false' order by timestamp desc`, function(err, rows, fields) {


 	        	//console.log(rows);

                res.write("  <span>Recent Notifications [<a href='/notifications'>View All</a>]</span> ");
                var noNotifs = true;
                for (k = 0; k < rows.length; k++) {
                	if(k == 5) {
                    	break;
                	}
                    if (rows.length > 0 ) {
                        noNotifs = false;

                        var message = "";
                        if(rows[k].notifmessage.indexOf('accepted')) {
                        	message = rows[k].notifmessage+ ` for ` + rows[k].servicename+` on `+String(rows[k].sched_date).slice(4, 10);
                        } else if(rows[k].notifmessage.indexOf('rejected')) {
                        	message = rows[k].notifmessage+` on `+String(rows[k].sched_date).slice(4, 10);
                        } else {
                        	message = rows[k].notifmessage;
                        }

                        res.write(`
						  <div class="reviewCont"> 
						  <div class="reviewHead"><span>`+new String(rows[k].timestamp).slice(4, 10)+`</span></div>
						  <div class="reviewDesc">
						   <p>`+message+`</p>
						  </div>
						  </div>
                        `);


                    } else {
                        noNotifs = true;
                    }

                }
                if (noNotifs) {
                    res.write(`<p>You have no notifications.</p>`);
                }
                res.end();
                queryDB("update notify_client set seen = 'true' WHERE seen = 'false'");
            
        });
        connection.end();
     } else if(action == 'fetch'){

        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query(`SELECT *  from notify_client 
            join appointments on notify_client.appointmentno = appointments.appointmentno
            join services on appointments.serviceid = services.serviceid
            join serviceprovider_schedules on appointments.sp_schedid = serviceprovider_schedules.schedid
            where receiver='` + sess.cid + `'  order by timestamp desc`, function(err, rows, fields) {

                var noNotifs = true;
                console.log(rows);
                for (k = 0; k < rows.length; k++) {  
                    if (rows.length > 0 ) {
                        noNotifs = false;

                        var message = "";
                        if(rows[k].notifmessage.indexOf('accepted')) {
                            message = rows[k].notifmessage+ ` for ` + rows[k].servicename+` on `+String(rows[k].sched_date).slice(4, 10);
                        } else if(rows[k].notifmessage.indexOf('rejected')) {
                            message = rows[k].notifmessage+` on `+String(rows[k].sched_date).slice(4, 10);
                        } else {
                            message = rows[k].notifmessage;
                        }
 
                        res.write(`<div class="columns large-4 text-center">
                            <ul class="no-bullet">
                            <li>
                            <span class='timestamp'>`+new String(rows[k].timestamp).slice(4, 10)+`</span><br>
                            <span class='message'>`+message+`</span> <br>
                            </li>
                         </ul></div>`);


                    } else {
                        noNotifs = true;
                    }

                }
                if (noNotifs) {
                    res.write(`<p>You have no notifications.</p>`);
                }
                res.end();
                queryDB("update notify_client set seen = 'true' WHERE seen = 'false'");

            });

     } else {
        res.render("notifications.html");
        res.end();        
    }
});





// Rating 
app.get('/ratings', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;
    var appointmentno = params.appointmentno;
    var rating = params.rating;

    if (action == 'rate') {
        queryDB("update appointments set rating = '"+rating+"' WHERE appointments.appointmentno = '" + appointmentno + "'");
        res.write("done");
        res.end("done");
    }
});



// Editinfos 
app.get('/edit', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;
	var value = params.value;

    if (action == 'email') {
        queryDB("update clients set email = '"+value+"' WHERE clientno = '" + sess.cid + "'");
        res.write("");
        res.end("done");
    } else if (action == 'contact') {
        queryDB("update clients set contactno = '"+value+"' WHERE clientno = '" + sess.cid + "'");
        res.write("");
        res.end("done");
    } else if (action == 'address') {
        queryDB("update clients set address = '"+value+"' WHERE clientno = '" + sess.cid + "'");
        res.write("");
        res.end("done");
    }
});




// Appointments
app.get('/appointments', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var action = params.action;

    if (!sess.username) {
        res.render("loginrequired.html");
    } else if (action == 'accepted' || action == 'request' || action == 'done') {
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query("SELECT *  from appointments inner join serviceprovider_schedules on appointments.sp_schedid = serviceprovider_schedules.schedid inner join clients on appointments.clientno = clients.clientno inner join serviceproviders on serviceprovider_schedules.spid = serviceproviders.spid inner join services on appointments.serviceid = services.serviceid where appointments.clientno='" + sess.cid + "' and status = '" + action + "'", function(err, rows, fields) {


            if (action == 'accepted') {

                res.write("<h4>Ongoing</h4>");
                var noAppointments = true;
                for (k = 0; k < rows.length; k++) {
                    if (rows[k].status == 'accepted') {
                        noAppointments = false;
                        res.write(`<ul>
                  <li><b>Service:</b> ` + rows[k].servicename + `</li>
                  <li><b>Price:</b> ` + rows[k].amount + ` Pesos</li>
                  <li><b>Schedule:</b> ` + new String(rows[k].sched_date).slice(0, 15) + ` ` + 
                         new String(rows[k].start_time).slice(0, 5) + ` - ` +  
                         new String(rows[k].end_time).slice(0, 5) + `</li>
                  </ul>`);
                    } else {
                        noAppointments = true;
                    }
                }
                if (noAppointments) {
                    res.write(`<span>You have no appointments right now.</span>`);
                }
                res.end();
            } else if (action == 'request') {
                res.write("<h4>Requests</h4>");
                var noRequests = true;
                for (k = 0; k < rows.length; k++) {
                    if (rows[k].status == 'request') {
                        noRequests = false;
                        res.write(`<ul>
                          <li><b>Service:</b> ` + rows[k].servicename + `</li>
                          <li><b>Price:</b> ` + rows[k].amount + ` Pesos</li>
                          <li><b>Schedule:</b> ` + new String(rows[k].sched_date).slice(0, 15) + ` ` + 
                          new String(rows[k].start_time).slice(0, 5) + ` - ` +  
                          new String(rows[k].end_time).slice(0, 5) + `</li>
                          <li><a href='/schedule?action=cancel&no=` + rows[k].appointmentno + `'>Cancel</a></li>
                          </ul>`);
                    } else {
                        noRequests = true;
                    }
                }
                if (noRequests) {
                    res.write(`<span>You have no requests right now.</span>`);
                }

                res.end();
            } else if (action == 'done') {
                res.write("<h4>Recently Finished</h4>");
                var noFinished = true;
                var fDisplayCount = 0;
                for (k = 0; k < rows.length; k++) {
                    if (rows[k].status == 'done' && fDisplayCount < 5) {
                        noFinished = false;


                          var rating = "";
                          if(rows[k].rating == '0') {
                          rating = `<b>Rating: </b><select style='width: 50px;' id="ratingform`+k+`" onchange="rate(this.getAttribute('id'), '`+rows[k].appointmentno+`'); this.style.display = 'none';">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                          </select>`;
                          } else {
                            rating = `<b>Rating: </b>`+rows[k].rating+``;
                          }

                        res.write(`<ul>
                          <li><b>Service:</b> ` + rows[k].servicename + `</li>
                          <li><b>Price:</b> ` + rows[k].amount + ` Pesos</li>
                          <li><b>Schedule:</b> ` + new String(rows[k].sched_date).slice(0, 15) + ` ` +
                          new String(rows[k].start_time).slice(0, 5) + ` - ` +  
                          new String(rows[k].end_time).slice(0, 5) + `</li>
                          <li>`+rating+`</li>
                          </ul>`);
                        fDisplayCount++;
                    } else {
                        noFinished = true;
                    }
                }
                if (noFinished) {
                    res.write(`<span>You have no finished transactions.</span>`);
                }

                res.end();
            }
        });
        connection.end();
    } else {

        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });

        connection.query("SELECT *  from appointments inner join serviceprovider_schedules on appointments.sp_schedid = serviceprovider_schedules.schedid inner join clients on appointments.clientno = clients.clientno inner join serviceproviders on serviceprovider_schedules.spid = serviceproviders.spid inner join services on appointments.serviceid = services.serviceid where appointments.clientno='" + sess.cid + "'", function(err, rows, fields) {
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            res.write("<html>\n<head>\n<title>User Appointments</title>");
            res.write("\n<html>\n<head>");
            res.write("\n<body>");
            //console.log(rows);
            if (err || rows.length <= 0) {
                res.write("\n<h1>No Apponintments at this time</h1>");
            } else {


                res.write("\n<h1>Ongoing Appointments</h1>");

                for (g = 0; g < rows.length; g++) {
                    if (rows[g].status == 'accepted') {
                        res.write("\n<ul>");
                        res.write("\n<li>Date: " + rows[g].start_time + "-" + rows[g].end_time + " " + rows[g].day_available + "</li>");
                        res.write("\n<li>Service: " + rows[g].servicename + "</li>");
                        res.write("\n<li>Price: " + rows[g].serviceamount + "</li>");
                        res.write("\n<li>Location: " + rows[g].address + "</li>");
                        res.write("\n<li>Service Provider: " + rows[g].first_name + " " + rows[g].last_name + "</li>");
                        res.write("\n<li> &nbsp; </li>");
                        res.write("\n</ul>");
                    }
                }

                res.write("\n<hr />");
                res.write("\n<h1>Sent Requests</h1>");

                for (g = 0; g < rows.length; g++) {
                    if (rows[g].status == 'request') {
                        res.write("\n<ul>");
                        res.write("\n<li>Date: " + rows[g].start_time + "-" + rows[g].end_time + " " + rows[g].day_available + "</li>");
                        res.write("\n<li>Service: " + rows[g].servicename + "</li>");
                        res.write("\n<li>Price: " + rows[g].serviceamount + "</li>");
                        res.write("\n<li>Location: " + rows[g].address + "</li>");
                        res.write("\n<li>Service Provider: " + rows[g].first_name + " " + rows[g].last_name + "</li>");
                        res.write("\n<li><a href='/schedule?action=cancel&no=" + rows[g].appointmentno + "'>Cancel</a></li>");
                        res.write("\n</ul>");
                    }
                }

            }
            res.write("\n</body>");
            res.write("\n</html>");
            res.end();
        });

        connection.end(function() {});
    }
});

// Schedule 
app.get('/schedule', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var sp_schedid = params.take;
    var serviceid = params.serviceid;
    var clientno = sess.cid;
    var action = params.action;
    var spid = params.spid;
    var appointmentno = params.no;
    var amount = params.price;

    if (!sess.username) {
        res.render("loginrequired.html");
    } else if (action == 'cancel') {
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query("select * from appointments where appointments.appointmentno = '" + appointmentno + "'", function(err, rows, fields) {
            if (err) {
                console.log(err);
            } else if (rows[0].status == 'accepted') {

                res.render("cannotcancel.html");

            } else {
                queryDB("update appointments set status = 'cancelled' WHERE appointments.appointmentno = '" + appointmentno + "' and status = 'request'");
                res.render("requestcancelled.html");
            }
            res.end();

        });

        connection.end();

    } else {
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query("select * FROM appointments WHERE sp_schedid = '" + sp_schedid + "' order by status desc", function(err, rows, fields) {
            console.log(rows);

            if (!err) {
                if (rows.length > 0 && rows[0].status == 'accepted' && rows[0].sp_schedid == sp_schedid) {
                    res.write("<h1>Sorry that schedule is already taken.</h1>");
                } else {
                    var post = {
                        sp_schedid,
                        clientno,
                        serviceid,
                        spid, 
                        amount
                    };
                    submitToDB(post, currentDB, "appointments");
                    console.log(post);
                    res.render("requestsent.html");
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
app.get('/search', function(req, res) {
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

    switch (period) {
        case 'morning':
            sign = " < ";
            break;
        case 'afternoon':
            sign = " > ";
            break;
    }

    if (sess.username && action == 'find') {
        res.writeHead(200, {
            "Content-Type": "text/html"
        });
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query(`SELECT * FROM serviceproviders 
            join serviceprovider_schedules on serviceproviders.spid = serviceprovider_schedules.spid 
            join sp_skills on serviceproviders.spid = sp_skills.spid 
            join services on sp_skills.serviceid = services.serviceid 
            where vacant = 'yes' and sched_date='` + day + `' and services.serviceid = '` + serviceid + `' and start_time ` + sign + ` '12:00:00'`, function(err, rows, fields) {
            if (err || rows.length <= 0) {
                res.end("\n<h1>No one is available at this schedule.</h1>");
            } else {
             for (r = 0; r < rows.length; r++) {

             var rating = rows[r].totalrating;
             if(rows[r].totalrating == 0) {
                rating = "No rating";
             }
	         res.write(`<div class="columns large-3">
	          <div class="card" data-equalizer-watch >
	            
	              <div class="card-divider">
	                `+rows[r].servicename+`
	              </div>
	              <div class="card-section">
	                <p><span><b>Time:</b> `+ rows[r].start_time + " - " + rows[r].end_time +`</span><br>
	                <span><b>Servvice Provider:</b> `+ rows[r].first_name + " " + rows[r].last_name +`</span><br>
                    <span><b>Service Quality:</b> ` + rating +`</span><br>
                    <span><b>Service Price:</b> ` + rows[r].price +`</span><br>
	                </p>
	                <a href="/schedule?take=` + rows[r].schedid + `&serviceid=` + rows[r].serviceid + `&spid=` + rows[r].spid + `&price=`+rows[r].price+`">
                    <input type="button" class="button" value="Request this Appointment">
	            	</a>
	              </div>
	          </div>
	        </div>`);
	    	}


                res.end();
            }

        });
        connection.end(function() {});

    } else if (sess.username) { // already logged in
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query("SELECT * from services where category='" + category + "' order by serviceid", function(err, rows, fields) {
            if (err || rows.length <= 0) {
                res.write("\n<h1>No categories are available right now.</h1>");
            } else {

		 		res.writeHead(200, {"Content-Type":"text/html"});
		 		// doctype to body
		 		res.write(`<!doctype html><html class="no-js" lang="en" dir="ltr"> <head> <meta charset="utf-8"> <meta http-equiv="x-ua-compatible" content="ie=edge"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Beauty x Beast</title> <link rel="stylesheet" href="css/foundation.css"> <link rel="stylesheet" href="css/app.css"> <script src="js/vendor/jquery.js"></script> <script src="js/vendor/what-input.js"></script> <script src="js/vendor/foundation.js"></script> <script src="js/app.js"></script> <script type='text/javascript' src='search.js'></script></head> <body>`);

		 		// nav
		 		res.write(`<nav class="top-bar"> <div class="top-bar-title"> <a href="/home"><img src="images/bxb.png"><strong>Beauty x Beast</strong></a> </div><div id="responsive-menu"> <div class="top-bar-right"> <ul class="menu dropdown" data-dropdown-menu> <li><a href="/home">Home</a></li><li><a href="/services">Services</a></li><li><a href="/transactions">Transactions</a></li><li><a href="home/?action=logout">Logout</a></li></ul> </div></div></nav>`);

		 		// header
		 		res.write(`<main> <div class="catalog-header"> <div class="row" > <div class="columns large-12 text-center"> <h1>Look for an Appointment</h1> </div></div>`);

		 		// search form
		 		res.write(` <div class="row" > <div class="columns large-2 large-offset-3"> <div class="input-group"> <h4>Service</h4> <select id="service">`);


                for (c = 0; c < rows.length; c++) {
                    res.write("<option value='" + rows[c].serviceid + "'>" + rows[c].servicename + "</option>");
                }


                res.write(`</select> </div></div><div class="columns large-4"> <div class="input-group"> <h4>Date</h4> <input id="day" type="date"/> <h4>Time Period</h4> <select id="period"> <option value="morning">7:00 - 12:00</option> <option value="afternoon">12:00 - 5:00</option> </select> <input type="button" id="find" class="button" value="Submit"> </div></div></div></div>`);


		 		// search results
		 		res.write(`<br><div class="row catalog" data-equalizer id="result"></div>`);



		 		res.write("</main>");


				// footer - html
				res.write(` <footer> <div class="row"> <div class="columns large-12"> <span>&copy; 2017 Beauty x Beast Inc, All Rights Reserved</span> </div></div></footer> </body></html>`);
				res.end();

            }
        });
        connection.end(function() {});

    } else {
        res.render("loginrequired.html");
        res.end();
        return false;
    }
});








// Services View
app.get('/services', function(req, res) {
    sess = req.session;
    if (sess.username) { // already logged in
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query("SELECT distinct category from services", function(err, rows, fields) {
            res.writeHead(200, {
                "Content-Type": "text/html"
            });

            // doctype to body
            res.write(`<!doctype html><html class="no-js" lang="en" dir="ltr"> <head> <meta charset="utf-8"> <meta http-equiv="x-ua-compatible" content="ie=edge"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Beauty x Beast | Services</title> <link rel="stylesheet" href="css/foundation.css"> <link rel="stylesheet" href="css/app.css"> <script src="js/vendor/jquery.js"></script> <script src="js/vendor/what-input.js"></script> <script src="js/vendor/foundation.js"></script> <script src="js/app.js"></script> </head> <body>`);
            // nav
            res.write(` <nav class="top-bar"> <div class="top-bar-title"> <a href="/home"><img src="images/bxb.png"><strong>Beauty x Beast</strong></a> </div><div id="responsive-menu"> <div class="top-bar-right"> <ul class="menu dropdown" data-dropdown-menu> <li><a href="/home">Home</a></li><li><a href="/services" class="current">Services</a></li><li><a href="/transactions">Transactions</a></li><li><a href="home/?action=logout">Logout</a></li></ul> </div></div></nav>`);

            res.write("<main>");

            // header
            res.write(`<div class="catalog-header"><div class="row" ><div class="columns large-12 text-center"><h1>Categories</h1></div></div></div><br>`);

            if (err || rows.length <= 0) {
                res.write("\n<h2>No services are available right now.</h2>");
            } else {
                //<a href=''>" + rows[c].category + "</a>

                res.write(`<div class="row catalog">`);

                for (c = 0; c < rows.length; c++) {
                    res.write(`<div class="columns large-3">
						          <div class="card" data-equalizer-watch="" style="height: 215px;">
						            <a href="/search?category=` + rows[c].category + `">
						              <div class="card-divider">
						                ` + new String(rows[c].category) + `
						              </div>
						              <img alt="` + rows[c].category + `" src="images/services/` + rows[c].category + `.jpg" onerror="this.src='images/ph.png'">
						            </a>
						          </div>
						        </div>`);
                }
                res.write(`</div>`);
            }

            res.write("</main>");

            // footer - html
            res.write(` <footer> <div class="row"> <div class="columns large-12"> <span>&copy; 2017 Beauty x Beast Inc, All Rights Reserved</span> </div></div></footer> </body></html>`);




            res.end();
        });
        connection.end();

    } else {
        res.render("loginrequired.html");
        res.end();
        return false;
    }

});

// Category View
app.get('/category', function(req, res) {
    sess = req.session;

    var url = require("url");
    var params = url.parse(req.url, true).query;
    var category = params.name;

    if (sess.username) { // already logged in
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });
        connection.query("SELECT serviceid, servicename from services where category='" + category + "'", function(err, rows, fields) {
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            res.write("<html><head><title>BxB " + category + " Service</title></head><body>");
            res.write("<h1>" + category + " Services</h1>");

            if (err || rows.length <= 0) {
                res.write("\n<h1>No services are available right now.</h1>");
            } else {
                res.write("<ul>");
                for (c = 0; c < rows.length; c++) {
                    res.write("<li><a href='/service/?id=" + rows[c].serviceid + "'>" + rows[c].servicename + "</a></li>");
                }
                res.write("</ul>");
            }

            res.write("</body></html>");
            res.end();
        });
        connection.end(function() {});

    } else {
        res.render("loginrequired.html");
        res.end();
        return false;
    }

});

// Service View
app.get('/service', function(req, res) {
    sess = req.session;

    var url = require("url");
    var params = url.parse(req.url, true).query;
    var id = params.id;

    if (sess.username) { // already logged in
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            if (err) {
                console.log(err);
            }
        });


        // list of sps
        connection.query("select services.description, serviceproviders.spid, services.serviceid, services.servicename, concat(serviceproviders.first_name, ' ', serviceproviders.last_name) as spname from services inner join sp_skills on services.serviceid = sp_skills.serviceid inner join serviceproviders on sp_skills.spid = serviceproviders.spid where services.serviceid='" + id + "' order by serviceproviders.spid", function(err, rows, fields) {
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            res.write("<html><head><title>BxB Service Details</title></head><body>");
            if (err || rows.length <= 0) {
                res.write("\n<h1>No services are available right now.</h1>");
                console.log(err);
            } else {
                res.write("<h1>" + rows[0].servicename + " Service Details</h1>");
                res.write("<p>" + rows[0].description + "</p>");
                res.write("<h2>Available Service Providers</h2>");
                for (c = 0; c < rows.length; c++) {
                    res.write("<li><a href='/provider/?id=" + rows[c].spid + "'>" + rows[c].spname + "</a></li>");
                }
            }

            res.write("</body></html>");
            res.end();
        });
        connection.end(function() {});

    } else {
        res.render("loginrequired.html");
        res.end();
        return false;
    }

});

// Chatbox
app.get('/chat', function(req, res) {
    sess = req.session;
    var url = require("url");
    var params = url.parse(req.url, true).query;
    var receiver = params.receiver;

    //console.log("action " + action);

    if (sess.username && params.view != "display" && params.view != "submit") { //Logged in
        res.writeHead(200, {
            "Content-Type": "text/html"
        });
        res.write("<html>" +
            "\n<head>\n<title>Chatbox Form</title>" +
            "\n<link rel='stylesheet' type='text/css' href='http://localhost:9000/chat/chat-style.css' />" +
            "\n<script type='text/javascript' src='http://localhost:9000/chat/chat-script.js'></script>" +
            "\n<script type='text/javascript'>\nvar loggedUser=\"" + sess.username + "\";\nvar receiver=\"" + receiver + "\";\n</script>" +
            "\n</head>" +
            "\n<body>");
        res.write("\n<h1>Chatting with " + params.receiver + "</h1>" +
            "\n<iframe name='chatsubmit' id='chatsubmit' src='#' style='display: none;'></iframe>" +
            "\n<form id='chatbox' action='http://localhost:9000/chat' target='chatsubmit' name='chatbox'>" +
            "\n<iframe id='msgbox' src='http://localhost:9000/chat?view=display&receiver=" + receiver + "'></iframe></div>" +
            "\n<input name='sender' type='hidden' value='" + sess.username + "' required />" +
            "\n<label for='msg'>Message: </label><textarea class='text' name='msg'></textarea>" +
            "\n<input name='receiver' type='hidden' value='" + receiver + "' />" +
            "\n<input name='view' type='hidden' value='submit' />" +
            "\n<input class='button' type='submit' value='Submit' />" +
            "\n<input class='button'  type='reset' value='Reset' />" +
            "\n</form>" +
            "\n<script type='text/javascript'>setTimeout(function(){fetchNewChatData();}, 3000);</script>");
        res.write("<a href='http://localhost:9000/home'>Home</a>");
        res.write("\n</body>" + "\n</html>");
        res.end();
    } else if (params.view == "display") {
        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            // in case of error
            if (err) {
                console.log(err);
            }
        });
        //var result = "";
        connection.query("SELECT * from messages where (client_username='" + sess.username + "' and sp_username='" + receiver + "')" +
            "order by timestamp limit 10",
            function(err, rows, fields) {
                if (err) {
                    console.log(err);
                    return;
                }

                res.writeHead(200, {
                    "Content-Type": "text/html"
                });
                res.write("<html><head><title>Messages</title>");
                res.write("<script type='text/javascript'>setTimeout(function() {window.location.reload();}, 5000);</script>");
                res.write("<link rel='stylesheet' type='text/css' href='http://localhost:9000/chat/chat-style.css' />");
                res.write("</head><body>");
                for (r = 0; r < rows.length; r++) {
                    //console.log(typeof rows.sender);
                    if (sess.username == rows[r].sender_username) { // your sent-messages [client]
                        res.write("\n<span class='sent'><span class='receiver'>" + sess.username + "</span>");
                        res.write("\n<span class='sent_message'>" + rows[r].message + "</span></span>");
                    } else { // what you received
                        res.write("\n<span class='received'><span class='sender'>" + receiver + "</span>");
                        res.write("\n<span class='received_message'>" + rows[r].message + "</span></span>");
                    }
                }
                res.write("\n</body></html>");
                res.end();
            });
    } else if (params.view == "submit") {

        var connection = mysql.createConnection({
            host: currentHost,
            user: dbuser,
            password: dbpass,
            database: currentDB,
        });
        connection.connect(function(err) {
            // in case of error
            if (err) {
                console.log(err);
            }
        });
        //var result = "";
        connection.query("SELECT username from serviceproviders where username='" + receiver + "'", function(err, rows, fields) {
            var sender_username = sess.username;
            var message = params.msg;
            var client_username = sess.username;
            var sp_username = receiver;
            var post = {
                sender_username,
                message,
                client_username,
                sp_username
            };
            submitToDB(post, currentDB, "messages");
            res.writeHead(200, {
                "Content-Type": "text/html"
            });
            res.write("<html><head><title>Message Sent</title></head><body></body></html>");
            res.end();
        });
        connection.end(function() {});
    } else {
        res.render("loginrequired.html");
        res.end();
        //return false;
    }

});