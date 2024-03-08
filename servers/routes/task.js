const express = require("express")
const Task = require("../models/task")
const Event = require('../models/event')
const Announcement = require('../models/announcement')
const taskRouter = express.Router()

taskRouter.post('/api/add-task', async (req, res) => {
    try {
        const { taskTitle, taskDescription, taskType, assignedTo, assignedBy, taskFile, remarks, taskStatus, } = req.body
        let task = new Task({ taskTitle, taskDescription, taskType, assignedTo, assignedBy, taskFile, remarks, taskStatus,})
        task = await task.save()
        res.json(task)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }

})

taskRouter.get('/api/tasks', async (req, res) => {
    try {
        const tasks = await Task.find({})
        res.json(tasks)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

taskRouter.get('xts', async (req, res) => {
    try {
        const events = await Event.find({})
        const announcements = await Announcement.find({})
        images = []
        events.forEach(element => {
            images.push(element.eventImage)
        });
        // console.log(announcements)
        announcements.forEach(element => {
            element.announcementImages.forEach(element => {

                images.push(element)
            });
        });
        // console.log(images)
        res.json(images)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

module.exports = taskRouter;
