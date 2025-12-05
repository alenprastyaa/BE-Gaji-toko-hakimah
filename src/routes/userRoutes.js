const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");
const auth = require("../middleware/auth");

router.post("/", auth("admin"), userController.createUser);
router.get("/", auth("admin"), userController.getAllUsers);
router.get("/:id", auth("admin"), userController.getUserById);
router.put("/:id", auth("admin"), userController.updateUser);
router.delete("/:id", auth("admin"), userController.deleteUser);

module.exports = router;
