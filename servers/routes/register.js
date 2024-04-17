const express = require('express')
const Register = require('../models/register')
const registerRouter = express.Router()


registerRouter.get('/api/registrations', async (req, res) => {
    try {
        const registrations = await Register.find({})
        res.json(registrations)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

registerRouter.post('/api/add-registration', async (req, res) => {
    try {
        const { eventName, eventAmount, participantsName, participantsRegisterNo, participantsCategory } = req.body
        let register = new Register({
            eventName, eventAmount, participantsName, participantsRegisterNo, participantsCategory
        })
        register = await register.save();
        res.json(register);

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

module.exports = registerRouter;