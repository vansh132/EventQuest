const express = require("express");
const Event = require("../models/event");
const eventRouter = express.Router();

//GET - All events list
eventRouter.get("/api/v1/events", async (req, res) => {
  try {
    const events = await Event.find({});
    res.json({ status: "success", data: events });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//GET - All UG events list
eventRouter.get("/api/v1/ug/events", async (req, res) => {
  try {
    const ugEvents = await Event.find({ eventCategory: "UG" });
    res.json({ status: "success", data: ugEvents });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//GET - All PG events list
eventRouter.get("/api/v1/pg/events", async (req, res) => {
  try {
    const pgEvents = await Event.find({ eventCategory: "PG" });
    res.json({ status: "success", data: pgEvents });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//POST - Add an event
eventRouter.post("/api/v1/add/event", async (req, res) => {
  try {
    const {
      eventName,
      eventDescription,
      eventAmount,
      eventImage,
      eventCategory,
      eventPublishedOn,
      eventNoOfParticipants,
      eventLink,
      eventContactPerson,
      eventContactPersonNo,
      eventRegistrationDeadline,
    } = req.body;
    let event = new Event({
      eventName,
      eventDescription,
      eventAmount,
      eventImage,
      eventCategory,
      eventPublishedOn,
      eventNoOfParticipants,
      eventLink,
      eventContactPerson,
      eventContactPersonNo,
      eventRegistrationDeadline,
    });
    event = await event.save();
    res.status(201).json({
      status: "Success",
      message: "Event created Successfully",
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//POST - Update an event
eventRouter.post("/api/v1/update/event", async (req, res) => {
  try {
    const id = req.query.id; //query params changed
    const event = await Event.findByIdAndUpdate(id, req.body);
    if (!event) {
      return res
        .status(204) //status code updated (when no content)
        .json({ message: `cannot find an event with ID ${id}` });
    }
    await Event.findById(id);
    res
      .status(200)
      .json({ status: "Success", message: "Event Updated Successfully" });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//POST - Delete an event
eventRouter.post("/api/v1/delete/event", async (req, res) => {
  try {
    const id = req.query.id;
    Event.findByIdAndDelete(id);

    res.status(200).json({
      status: "Success",
      message: "Event Deleted Successfully",
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = eventRouter;
