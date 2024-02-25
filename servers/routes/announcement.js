const express = require('express')
const Announcement = require('../models/announcement')
const announcementRouter = express.Router()

announcementRouter.get('/api/announcements', async (req, res) => {
    try {
        const announcements = await Announcement.find({})
        res.json(announcements)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

announcementRouter.post('/api/add-announcement', async (req, res) => {
    try {
        const { announcementTitle, announcementDescription, announcementImages, announcementPublishedOn, announcementPublishedBy } = req.body
        let announcement = new Announcement({
            announcementTitle, announcementDescription, announcementImages, announcementPublishedOn, announcementPublishedBy
        })
        announcement = await announcement.save();
        res.json(announcement);

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

announcementRouter.put('/api/update-announcement/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const announcement = await Announcement.findByIdAndUpdate(id, req.body)
        if (!announcement) {
            return res.status(400).json({ message: `cannot find an announcement with ID ${id}` })
        }
        const updatedAnnouncement = await Announcement.findById(id)
        res.status(200).json(updatedAnnouncement);

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

announcementRouter.post('/api/delete-announcement', async (req, res) => {
    try {
        const { id } = req.body;
        announcements = await Announcement.findByIdAndDelete(id);
        res.status(200).json(announcements);
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

module.exports = announcementRouter;