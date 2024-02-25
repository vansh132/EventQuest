const express = require('express')
const mongoose = require('mongoose')
const userRouter = require('./routes/user')
const eventRouter = require('./routes/event')
const announcementRouter = require('./routes/announcement')


const app = express()

const PORT = 3000
const DB = "mongodb+srv://vansh:vansh@eventquest.p0fpk2f.mongodb.net/?retryWrites=true&w=majority"

app.use(express.json());

//Routes
app.use(userRouter)
app.use(eventRouter)
app.use(announcementRouter)

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful...");
  })
  .catch((e) => {
    console.log(e);
  });



app.listen(PORT, "0.0.0.0", () => {
  console.log("Connected at port " + PORT);
});