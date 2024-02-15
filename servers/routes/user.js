const express = require('express')
const bcryptjs = require('bcryptjs')
const User = require('../models/user')
const userRouter = express.Router();

userRouter.post('/api/signup', async (req, res) => {
    try {
        const { username, password, type } = req.body;

        // Validation: If user already exists
        const existingUser = await User.findOne({ username })
        if (existingUser) {
            return res.status(400).json({ msg: 'User with same username already exist' })
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({ username, password: hashedPassword, type });

        user = await user.save();

        res.json(user)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }
})

userRouter.post('/api/signin', async (req, res) => {

    try {

        const { username, password } = req.body;
        // console.log("cec")
        const user = await User.findOne({ username })


        if (!user) {
            // console.log("dowsnt exits")
            return res.json({ msg: "User with this username does not exist" })
        }

        const isMatch = await bcryptjs.compare(password, user.password);

        if (!isMatch) {
            return res.json({ msg: "Incorrect Password" })
        }

        // console.log(user._doc)
        res.json(user._doc)
    } catch (error) {
        res.status(500).json({ error: error.message })
    }

})

module.exports = userRouter;
