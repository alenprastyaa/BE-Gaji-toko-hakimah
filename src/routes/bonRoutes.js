const express = require("express");
const router = express.Router();
const bonController = require("../controllers/bonController");
const auth = require("../middleware/auth");

router.post("/", auth(["karyawan", "admin"]), bonController.createBon);
router.get("/my-bons", auth(["karyawan", "admin"]), bonController.getUserBons);
router.get("/", auth("admin"), bonController.getAllBons);
router.put("/:id", auth(["karyawan", "admin"]), bonController.updateBon);
router.delete("/:id", auth(["karyawan", "admin"]), bonController.deleteBon);

module.exports = router;
