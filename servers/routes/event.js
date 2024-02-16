const express = require('express')
const Event = require('../models/event')
const eventRouter = express.Router()

eventRouter.post('/api/add-event', async (req, res) => {
    try {
        const { eventName, eventDescription, eventAmount, eventImage, eventCategory, eventPublishedOn, eventNoOfParticipants, eventLink, eventContactPerson, eventContactPersonNo, eventRegistrationDeadline, } = req.body
        let event = new Event({ eventName, eventDescription, eventAmount, eventImage, eventCategory, eventPublishedOn, eventNoOfParticipants, eventLink, eventContactPerson, eventContactPersonNo, eventRegistrationDeadline, })
        event = await event.save()
        res.json(event)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }

})

eventRouter.get('/api/events', async (req, res) => {
    try {
        const events = await Event.find({})
        res.json(events)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

module.exports = eventRouter;