var express = require('express');
var mongoose = require('mongoose');
var Todo = require('./models/todo');
var User = require('./models/user');
var bodyParser = require('body-parser');
var validator = require("email-validator");
var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
var jwt = require('jwt-simple');

const secret = "Myververylong109210amazonfjing*secr*()";

var app = express();
app.use(bodyParser.urlencoded({ extended: true }));

mongoose.connect("mongodb://0.0.0.0/todo_1");

app.use(passport.initialize());
passport.use(new LocalStrategy(User.authenticate()));

//------------------------------------------------------------------------------------------------
// Routes
//------------------------------------------------------------------------------------------------

app.get("/todos", isAuthenticated, findUser, function(req, res) {
	res.json({
		error: null,
		data: req.user.todos
	});
});

app.post("/todos/create", isAuthenticated, findUser, function(req, res) {
	var description = req.body.description;
	if (!description || description.trim().length == 0) {
		return res.status(403).json({
			error: {
				code: 403,
				message: "Please enter a valid description"
			},
			data: null
		});
	}
	var user = req.user;
	Todo.create( { description: description.trim(), userID: user._id }, function(error, todo) {
		if (error) {
			return res.status(500).json(dbErrorResponse);
		}
		user.todos.push(todo);
		user.save(function(error, savedUser) {
			if (error) {
				return res.status(500).json(dbErrorResponse);
			}
			res.json({
				error: null,
				data: todo
			});
		});
	});
});

app.patch("/todos/:todoID", isAuthenticated, findUser, function(req, res) {
	var description = req.body.description;
	if (!description || description.trim().length == 0) {
		return res.status(403).json({
			error: {
				code: 403,
				message: "Please enter a valid description"
			},
			data: null
		});
	}
	Todo.findOne({ _id: req.params.todoID, userID: req.user._id }, function(error, todo) {
		if (error || !todo) {
			return res.status(404).json({
				error: {
					code: 404,
					message: "The todo item was not found"
				},
				data: null
			});
		}
		todo.description = description.trim();
		todo.save(function(error, saved) {
			if (error) {
				return res.status(500).json({
					error: {
						code: 500,
						message: "The item could not be saved"
					},
					data: null
				});
			}
			res.json({
				error: null,
				data: saved
			});
		})
	});
});

app.delete("/todos/:todoID", isAuthenticated, findUser, function(req, res) {
	var userID = req.user._id;
	var todoID = req.params.todoID;
	Todo.findOneAndRemove({ _id: todoID, userID: userID }, function(error) {
		if (error) {
			return res.status(500).json(dbErrorResponse);
		}
		res.json({
			error: null,
			message: "Deleted"
		});
	});
})

app.post("/register", function(req, res) {
	var email = req.body.username;
	var password = req.body.password;
	if (!email || !password) {
		res.json({
			error: {
				code: 1002,
				message: "Please enter a valid email and password"
			},
			data: null
		});
		return;
	}
	email = email.toLowerCase();
	if (!validator.validate(email)) {
		res.json({
			error: {
				code: 1003,
				message: "Please enter a valid email address"
			},
			data: null
		});
		return;
	}
	if (password.length < 6) {
		res.json({
			error: {
				code: 1004,
				message: "Please enter a strong password"
			},
			data: null
		});
		return;
	}

	User.findOne({ username: email }, function(error, existingUser) {
		if (error) {
			return res.status(500).json(dbErrorResponse);
		}
		if (existingUser) {
			return res.status(403).json({
				data: null,
				error: {
					code: 403,
					message: "This email address is already in use"
				}
			})
		}

		User.register(new User({ username: email }), req.body.password, function(error) {
			if (error) {
				return res.json({
					error: {
						code: 500,
						message: error
					},
					data: null
				});
			}
			User.findOne({ username: email }, function(error, user) {
				if (error || !user) {
					return res.status(500).json({
						error: {
							code: 500,
							message: "Internal server error"
						},
						data: null
					});
				}
				var userInfo = { userID: user._id, iat: new Date() };
				var token = jwt.encode(userInfo, secret);
				var userObject = user.toObject();
				delete userObject.hash;
				delete userObject.salt;
				res.status(200).json({
					error: null,
					data: {
						token: token,
						user: userObject
					}
				});
			});
		});
	});

});

app.post('/login', passport.authenticate('local', { session: false }), function(req, res) {
	var userInfo = { userID: req.user._id, iat: new Date() };
	var token = jwt.encode(userInfo, secret);
	var userObject = req.user.toObject();
	delete userObject.hash;
	delete userObject.salt;
	res.status(200).json({
		error: null,
		data: {
			token: token,
			user: userObject
		}
	});
});


//------------------------------------------------------------------------------------------------
// Middleware
//------------------------------------------------------------------------------------------------

var noUserResponse = {
	error: {
		code: 404,
		message: "User not found"
	},
	data: null
}

var dbErrorResponse = {
	error: {
		code: 2001,
		message: "There was a problem with the database"
	},
	data: null
}

function isAuthenticated(req, res, next) {
	var unauthorizedError = {
		error: {
			code: 401,
			message: "Please login to continue"
		},
		data: null
	}

	var authHeader = req.headers['authorization'];
	if (!authHeader) {
		return res.status(401).json(unauthorizedError);
	}
	var components = authHeader.split(' ');
	if (components.length !== 2) {
		return res.status(401).json(unauthorizedError);
	}
	if (components[0].toLowerCase().trim() !== 'bearer') {
		return res.status(401).json(unauthorizedError);
	}
	var token = components[1].trim();
	var decoded
	try {
		decoded = jwt.decode(token, secret);
	}
	catch(err) {
		return res.status(401).json(unauthorizedError);
	}
	if (!decoded) {
		return res.status(401).json(unauthorizedError);
	}
	var userID = decoded.userID;
	if (!userID) {
		return res.status(401).json(unauthorizedError);
	}
	req.userID = userID;
	next();
}

function findUser(req, res, next) {
	var userID = req.userID;
	if (!userID) {
		return res.status(404).json({
			error: {
				code: 404,
				message: "User not found"
			}
		});
	}
	User.findOne({ _id: userID }).populate({ path: "todos" }).exec(function (error, user) {
		if (error || !user) {
			return res.status(404).json({
				error: {
					code: 404,
					message: "User not found"
				}
			});
		}
		req.user = user;
		next();
	});
}

app.listen(4000, "127.0.0.1", function() {
	console.log("started server!");
})
