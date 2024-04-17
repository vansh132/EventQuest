const mongoose = require('mongoose');

const registerSchema = mongoose.Schema({
    eventName: {
        type: String,
        required: true
    },

    eventAmount: {
        type: String,
        required: true
    },

    participantsName:
        [{
            type: String,
            required: true
        }],

    participantsRegisterNo: [{
        type: String,
        required: true
    }],
    participantsCategory: [{
        type: String,
        required: true
    }]
})

const Registration = mongoose.model('Registration', registerSchema);
module.exports = Registration;