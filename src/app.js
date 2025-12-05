const express = require("express");
const cors = require("cors");
const sequelize = require("./config/database");
const authRoutes = require("./routes/authRoutes");
const bonRoutes = require("./routes/bonRoutes");
const userRoutes = require("./routes/userRoutes");
const userCuti = require("./routes/cutiRoutes");

const app = express();
app.use(cors());
app.use(express.json());
app.use("/api/auth", authRoutes);
app.use("/api/bon", bonRoutes);
app.use("/api/users", userRoutes);
app.use("/api/cuti", userCuti);
app.get("/", (req, res) => {
  res.send("Employee Bon Backend API is running!");
});
const initializeDatabase = async () => {
  try {
    await sequelize.authenticate();
    console.log("Database connection established successfully.");
    initializeAssociations();
    await sequelize.sync({ alter: true });
    console.log("All models synchronized successfully.");

  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
};
initializeDatabase();

module.exports = app;
