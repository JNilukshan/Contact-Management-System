const express = require("express");
const router = express.Router();
const {getContacts,createContact,updateContact,deleteContact,getContact} = require("../controllers/contactController");
const validateToken = require("../midleware/validateTokenHandler");

router.use(validateToken);
// Get all contacts
router.route("/").get(getContacts);

// Get contact by ID
router.route("/:id").get(getContact);

// Create a new contact
router.route("/").post(createContact);

// Update contact by ID
router.route("/:id").put(updateContact); 

// Delete contact by ID
router.route("/:id").delete(deleteContact);



module.exports = router;
