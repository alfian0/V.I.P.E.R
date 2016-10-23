var mongoose = require('mongoose');

var todoSchema = mongoose.Schema({
	description: String,
	userID: mongoose.Schema.Types.ObjectId
});

module.exports = mongoose.model("Todo", todoSchema);
