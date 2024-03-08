const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    username: {
        type: String,
        required: true,
        trim: true
    },
    password: {
        type: String,
        required: true
    },
    type: {
        type: String,
        default: "Student",
    }
})

const User = mongoose.model('Users', userSchema);
module.exports = User;