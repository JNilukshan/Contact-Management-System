const asyncHandler =require ("express-async-handler");
const bcrypt = require ("bcrypt");
const jwt = require("jsonwebtoken");
const User = require ("../models/userModel");

//@desc Regester a user
//@route POST/api/users/register
//@access public
const registerUser = asyncHandler(async (req,res) => {
    const {username, email, password} = req.body;
    if(!username || !email || !password){
        res.status(400);
        throw new Error("All field are mandotory");
    }
    const userAvailable = await User.findOne({ email });
    if (userAvailable){
        res.status(400);
        throw new Error("User already registered");
    }

    //hash password
    const hashedPassword = await bcrypt.hash(password, 10);
    console.log("Hash Password: ",hashedPassword );
    const user = await User.create({
        username,
        email,
        password: hashedPassword,
    });

    console.log(`User Created ${user}`);
    if (user) {
        res.status(201).json({_id: user.id, email: user.email});
    } else{
        res.status(400);
        throw new Error("User data is not valid");
    }
    
});


//@desc Login user
//@route POST/api/users/login
//@access public
const loginUser = asyncHandler(async (req,res) => {
    const {email,password} = req.body;
    if (!email || !password) {
        res.status(400);
        throw new Error ("All fields are mandotory!");
    }
    const user = await User.findOne({email});
    //compare the password and hash password
    if (user && (await bcrypt.compare(password, user.password))) {
        const accessToken = jwt.sign({  //payload
            user: {
                username: user.username,
                email: user.email,
                id: user.id,
            },
        }, 
        process.env.ACCESS_TOKEN_VALUE,
        {expiresIn: "15m"}
    );
        res.status(200).json({accessToken});
    } else {
        res.status(401);
        throw new Error("Email or Password is not valid")
    }
});


//@desc Current user information
//@route POST/api/users/current
//@access privat
const currentUser = asyncHandler(async (req,res) => {
    res.json(req.user);
});


module.exports = {registerUser,loginUser,currentUser}