const express = require("express");
const errorHandler = require("./midleware/errorhandler");
const connectDb = require("./cofig/dbConnection");
const dotenv = require("dotenv").config();

connectDb();
const app = express();

const port = process.env.PORT || 5000;

// Middleware to parse JSON (move this above routes)
app.use(express.json());

// Use the contact routes
app.use("/api/contacts", require("./routes/contactRoutes"));

// Authentication
app.use("/api/users", require("./routes/userRoutes"));

// Middleware to handle errors
app.use(errorHandler);

// Start the server
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
