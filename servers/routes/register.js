const express = require('express')
const Register = require('../models/register')
const registerRouter = express.Router()

// GET - All Registrations
registerRouter.get('/api/v1/registrations', async (req, res) => {
    try {
        const registrations = await Register.find({})
        res.json(registrations)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

// POST - Registration Form
registerRouter.post('/api/v1/registrations', async (req, res) => {
    try {
        const { eventName, eventAmount, eventCategory, eventNoOfParticipants, userName, participantsName, participantsRegisterNo, participantsCategory } = req.body
        let register = new Register({
            eventName, eventAmount, eventCategory, eventNoOfParticipants, userName, participantsName, participantsRegisterNo, participantsCategory
        })
        register = await register.save();
        res.json(register);

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

module.exports = registerRouter;