const mongoose = require('mongoose');

const registerSchema = mongoose.Schema({
    eventName: {
        type: String,
        required: true
    },

    eventAmount: {
        type: Number,
        required: true
    },

    eventCategory: {
        type: String,
        required: true,

    },

    eventNoOfParticipants: {
        type: Number,
        required: true
    },

    userName: {
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