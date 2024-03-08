const mongoose = require('mongoose')

const taskSchema = mongoose.Schema({
    taskTitle: {
        type: String,
        required: true,
    },
    taskDescription: {
        type: String,
        required: true,
    },
    taskType: {
        type: String,
        required: true,
    },
    assignedTo: {
        type: String,
        required: true,
    },
    assignedBy: {
        type: String,
        required: true,
    },
    taskFile: {
        type: String,
        required: true
    },
    remarks: [{
        type: String,
        required: true
    }],
    taskStatus: {
        type: Boolean,
        required: true
    }
})

const Task = mongoose.model('Tasks', taskSchema);
module.exports = Task;

// final String taskTitle;
// final String taskDescription;
// final String taskType;
// final String assignedTo;
// final String assignedBy;
// File? file;
// String? remarks;
// final String taskStatus;