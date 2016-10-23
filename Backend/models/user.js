var mongoose = require('mongoose');
var Todo = require('./todo');
var passportLocalMongoose = require('passport-local-mongoose');

var userSchema = mongoose.Schema({
	username: String,
	todos: [
		{ type: mongoose.Schema.Types.ObjectId, ref: 'Todo'}
	]
});

userSchema.plugin(passportLocalMongoose, { usernameLowerCase: true });

module.exports = mongoose.model("User", userSchema);
