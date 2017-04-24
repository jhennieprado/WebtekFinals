// Registration Form Server
var form = require("http");
form.createServer(function(request, response){
    response.writeHead(200, {"Content-Type":"text/html"});

    //var userIDs = "SELECT userid FROM user_details";
    //var userIDs = getDataFromDB(userIDs);

    response.write("<html><head><title>Registration Form</title></head>"+
    	"\n<body>"+
    	"\n<h1>User Registration</h1>"+
    	"<iframe name='sub' id='sub' src='#' style='display: none;'></iframe>"+
    	"\n<form action='http://localhost:8083/' target='sub' name='registration'>"+
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
var submit = require("http");
submit.createServer(function(request, response){
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
	var mysql      = require('mysql');
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
	connection.query('INSERT INTO user_details SET ?', post, function(err, result) {
	 // Neat!
	  //console.log(err);
	});
    connection.end(function(){
    //The connection has been closed
	});
}).listen(8083);


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
