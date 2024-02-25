const mongoose = require('mongoose')

const announcementSchema = mongoose.Schema({
    announcementTitle: {
        type: String,
        required: true
    },
    announcementDescription: {
        type: String,
        required: true
    },
    announcementImages: [{
        type: String,
        required: true
    }],
    announcementPublishedOn: {
        type: Date,
        required: true
    },
    announcementPublishedBy: {
        required: true,
        type: Object,

    }
})

const Announcement = mongoose.model('Announcements', announcementSchema);
module.exports = Announcement;