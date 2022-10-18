var express = require("express");
var app = express();
var fs = require("fs");
var bodyParser = require("body-parser");

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  res.header("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS");
  next();
});

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

// Handle GET method for listing all ...
app.get("/listMovies", function (req, res) {
  fs.readFile(__dirname + "/" + "db.json", function (err, data) {
    console.log("Data is " + data);
    res.end(data);
  });
});

// Hanlde GET method for listing all users
app.get("/listUsers", function (req, res) {
  fs.readFile(__dirname + "/" + "users.json", function (err, data) {
    console.log("Data is " + data);
    res.send(data);
  });
});

app.get("/listUsers/:email", function (err, user) {
  fs.readFile(__dirname + "/" + "users.json", "utf-8", function (err, data) {
    users = JSON.parse(data);

    // var user = users["user" + req.pamas.email];
    // var user = users.find(users['email', req.params.email]);
    var user = users.find((user) => user.email == email);
    console.log(user);
    res.end(JSON.stringify(user));
  });
});

// Handle GET method to get only one record
app.get("/:id", function (req, res) {
  fs.readFile(__dirname + "/" + "db.json", "utf-8", function (err, data) {
    movies = JSON.parse(data);
    console.log(req.params.id);
    var movie = movies["movie" + req.params.id];
    console.log(movie);
    res.end(JSON.stringify(movie));
  });
});

// Handle POST method
app.post("/addmovie", function (req, res) {
  // First read existing movie
  fs.readFile(__dirname + "/" + "db.json", function (err, data) {
    var obj = JSON.parse("[" + data + "]");
    obj.push(req.body);
    console.log(obj);

    res.end(JSON.stringify(obj));
  });
});

// Handle DETELET method
app.delete("/deleteMovie/:id", function (req, res) {
  // Frist read existing data
  fs.readFile(__dirname + "/" + "db.json", function (err, data) {
    {
      data = JSON.parse(data);

      delete data[("movie", req.params.id)];

      console.log("data is " + data);

      res.end(JSON.stringify(data));
    }
  });
});

// Handle updat method
app.put("/updateMovie:id", function (rq, res) {
  // First read exisiting movie,
  fs.readFile(__dirname + "/" + "db.json", function (err, data) {
    data = JSON.parse(data);

    arr = rq.body;

    data["movie" + rq.params.id] = arr[Object.keys(arr)[0]];

    res.end(JSON.stringify(data));
  });
});

app.put("/updateProfile/:id", (rq, res) => {
  fs.readFile(__dirname + "/" + "users.json", function (err, data) {
    id = rq.params.id - 1
    data = JSON.parse(data);
    arr = rq.body
    data["users"][id]["email"] = rq.body.email//arr[Object.keys(arr)[0]];
    res.end(JSON.stringify(rq.body.email));
  });
});

var server = app.listen(8080, function () {
  // var host = "localhost"; //server.address().address
  var host = "10.0.2.2"; //server.address().address
  var port = 8080; //server.address.port

  console.log("Server is running at ", host, port);
});
