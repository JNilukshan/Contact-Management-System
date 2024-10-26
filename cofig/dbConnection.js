// connect the database 
const mongoose =require("mongoose");

const connectDb = async () => {
    try {
        const connect =await mongoose.connect(process.env.CONNECTION_STRING);
        console.log(
            "Database is Connected: ",
            connect.connection.host,
            connect.connection.name
        );
    } catch (err) {
        console.log(err);
        prosecc.exit(1);
    }
}

module.exports = connectDb;