// routes/cutiRoutes.js
const express = require("express");
const router = express.Router();
const cutiController = require("../controllers/cutiController");
const auth = require("../middleware/auth");

router.get("/", auth("admin"), cutiController.getAllCuti);
router.get("/:id", auth("admin"), cutiController.getCutiById);
router.post("/", auth("admin"), cutiController.createCuti);
router.put("/:id", auth("admin"), cutiController.updateCuti);
router.get("/my/cuti", auth(["karyawan", "admin"]), cutiController.getMyCuti)
router.post("/my/cuti", auth(["karyawan", "admin"]), cutiController.createMyCuti)
router.delete("/:id", auth("admin"), cutiController.deleteCuti);

module.exports = router;
