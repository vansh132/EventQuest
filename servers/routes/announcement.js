const express = require('express')
const Announcement = require('../models/announcement')
const announcementRouter = express.Router()

// GET - All Announcement 
announcementRouter.get('/api/v1/announcements', async (req, res) => {
    try {
        const announcements = await Announcement.find({})
        res.json({ status: 'success', data: announcements })
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

// POST - Add Announcement
announcementRouter.post('/api/v1/announcements', async (req, res) => {
    try {
        const { announcementTitle, announcementDescription, announcementImages, announcementPublishedOn, announcementPublishedBy } = req.body
        let announcement = new Announcement({
            announcementTitle, announcementDescription, announcementImages, announcementPublishedOn, announcementPublishedBy
        })
        announcement = await announcement.save();
        res.status(201).json({
            status: "Success",
            message: "Announcement created Successfully",
        });

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

// PUT - Update Announcement
announcementRouter.put('/api/v1/announcements/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const announcement = await Announcement.findByIdAndUpdate(id, req.body)
        if (!announcement) {
            return res.status(400).json({ message: `cannot find an announcement with ID ${id}` })
        }
        const updatedAnnouncement = await Announcement.findById(id)
        res
            .status(200)
            .json({ status: "Success", message: "Announcement Updated Successfully" });

    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

// DELETE - Delete an Announcement
announcementRouter.delete('/api/v1/announcements/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const announcement = await Announcement.findByIdAndDelete(id);

        if (!announcement) {
            return res.status(404).json({ status: "Failure", message: "Announcement not found" });
        }

        res.status(200).json({ status: "Success", message: "Announcement Deleted Successfully" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


module.exports = announcementRouter;