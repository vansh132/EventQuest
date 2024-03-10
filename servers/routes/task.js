const express = require("express");
const Task = require("../models/task");
const Event = require("../models/event");
const Announcement = require("../models/announcement");
const taskRouter = express.Router();

taskRouter.post("/api/add-task", async (req, res) => {
  try {
    const {
      taskTitle,
      taskDescription,
      taskType,
      assignedTo,
      assignedBy,
      taskFile,
      remarks,
      taskStatus,
    } = req.body;
    let task = new Task({
      taskTitle,
      taskDescription,
      taskType,
      assignedTo,
      assignedBy,
      taskFile,
      remarks,
      taskStatus,
    });
    task = await task.save();
    res.json(task);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

taskRouter.get("/api/tasks", async (req, res) => {
  try {
    const tasks = await Task.find({});
    res.json(tasks);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

taskRouter.get("/api/tasks/:assignedBy", async (req, res) => {
  try {
    const { assignedBy } = req.params;
    const tasks = await Task.find({ assignedBy: assignedBy });
    // console.log(tasks.length)
    if (tasks.length == 0) {
      return res
        .status(400)
        .json({ message: `cannot find an tasks with username: ${assignedBy}` });
    }
    res.json(tasks);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

taskRouter.get("/api/tasks/assignedTo/:assignedTo", async (req, res) => {
  try {
    const { assignedTo } = req.params;
    const tasks = await Task.find({
      assignedTo: assignedTo,
      taskStatus: false,
    });
    // console.log(tasks.length)
    if (tasks.length == 0) {
      return res
        .status(400)
        .json({ message: `cannot find an tasks with username: ${assignedTo}` });
    }
    res.json(tasks);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

taskRouter.get(
  "/api/tasks/assignedTo/history/:assignedTo",
  async (req, res) => {
    try {
      const { assignedTo } = req.params;
      const tasks = await Task.find({
        assignedTo: assignedTo,
        taskStatus: true,
      });
      // console.log(tasks.length)
      if (tasks.length == 0) {
        return res.status(400).json({
          message: `cannot find an tasks with username: ${assignedTo}`,
        });
      }
      res.json(tasks);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
);

taskRouter.get("/api/highlights", async (req, res) => {
  try {
    const events = await Event.find({});
    const announcements = await Announcement.find({});
    images = [];
    events.forEach((element) => {
      images.push(element.eventImage);
    });
    // console.log(announcements)
    announcements.forEach((element) => {
      element.announcementImages.forEach((element) => {
        images.push(element);
      });
    });
    // console.log(images)
    res.json(images);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

taskRouter.post("/api/add-poster/:taskId", async (req, res) => {
  try {
    const { taskId } = req.params;
    const task = await Task.findByIdAndUpdate(taskId, req.body);
    if (!task) {
      return res.status(400).json({ message: `cannot find an task` });
    }
    const updatedTask = await Task.findById(id);
    res.status(200).json(updatedTask);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = taskRouter;
