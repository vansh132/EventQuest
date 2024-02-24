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

eventRouter.get('/api/events/ug', async (req, res) => {
    try {
        const ugEvents = await Event.find({ eventCategory: "UG" })
        res.json(ugEvents)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

eventRouter.get('/api/events/pg', async (req, res) => {
    try {
        const pgEvents = await Event.find({ eventCategory: "PG" })
        res.json(pgEvents)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

eventRouter.put('/api/update-event/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const event = await Event.findByIdAndUpdate(id, req.body)
        if (!event) {
            return res.status(400).json({ message: `cannot find an event with ID ${id}` })
        }
        const updatedEvent = await Event.findById(id)
        res.status(200).json(updatedEvent);
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

eventRouter.post('/api/delete-event', async (req, res) => {
    try {
        const { id } = req.body;
        const event = await Event.findByIdAndDelete(id);

        res.status(200).json(event);
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

module.exports = eventRouter;