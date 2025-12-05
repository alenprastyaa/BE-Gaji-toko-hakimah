const Bon = require("../models/Bon");
const User = require("../models/User");
const { Op } = require("sequelize");

exports.createBon = async (req, res) => {
  const { tanggal, jumlahBon, keperluan } = req.body;
  const userId = req.user.id;

  try {
    const newBon = await Bon.create({ tanggal, jumlahBon, keperluan, userId });
    res.status(201).json(newBon);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error creating bon", error: err.message });
  }
};

exports.getUserBons = async (req, res) => {
  const userId = req.user.id;
  try {
    const bons = await Bon.findAll({
      where: { userId },
      as: "bons",
      order: [["tanggal", "DESC"]],
    });
    const totalBon = bons.reduce(
      (sum, bon) => sum + parseFloat(bon.jumlahBon),
      0
    );
    res.json({ bons, totalBon });
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ message: "Error fetching user bons", error: err.message });
  }
};

exports.getAllBons = async (req, res) => {
  const { userId, month, year, userStatus } = req.query;
  let whereClause = {};

  if (userId) {
    whereClause.userId = userId;
  }
  if (month && year) {
    const startDate = new Date(year, month - 1, 1);
    const endDate = new Date(year, month, 0);

    whereClause.tanggal = {
      [Op.between]: [
        startDate.toISOString().split("T")[0],
        endDate.toISOString().split("T")[0],
      ],
    };
  }
  else if (year) {
    const startDate = new Date(year, 0, 1);
    const endDate = new Date(year, 11, 31);

    whereClause.tanggal = {
      [Op.between]: [
        startDate.toISOString().split("T")[0],
        endDate.toISOString().split("T")[0],
      ],
    };
  }

  const userWhere = {};
  if (userStatus) {
    userWhere.status = userStatus;
  }

  try {
    const bons = await Bon.findAll({
      where: whereClause,
      include: [
        {
          model: User,
          as: "karyawan",
          where: userWhere,
          attributes: ["id", "username", "namaLengkap", "status"],
        },
      ],
      order: [["tanggal", "DESC"]],
    });

    const totalBonKeseluruhan = bons.reduce(
      (sum, bon) => sum + parseFloat(bon.jumlahBon),
      0
    );

    res.json({ bons, totalBonKeseluruhan });
  } catch (err) {
    console.error(err);
    res.status(500).json({
      message: "Error fetching all bons",
      error: err.message,
    });
  }
};


exports.updateBon = async (req, res) => {
  const { id } = req.params;
  const { tanggal, jumlahBon, keperluan } = req.body;
  const userId = req.user.id;

  try {
    const bon = await Bon.findOne({ where: { id, userId } });
    if (!bon) {
      return res
        .status(404)
        .json({ message: "Bon not found or you do not have permission" });
    }

    bon.tanggal = tanggal;
    bon.jumlahBon = jumlahBon;
    bon.keperluan = keperluan;
    await bon.save();
    res.json(bon);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error updating bon", error: err.message });
  }
};

// Delete Bon
exports.deleteBon = async (req, res) => {
  const { id } = req.params;
  const userId = req.user.id; // User yang melakukan delete

  try {
    // Admin bisa delete bon siapapun, karyawan hanya bisa delete bon miliknya
    let bon;
    if (req.user.role === "admin") {
      bon = await Bon.findByPk(id);
    } else {
      bon = await Bon.findOne({ where: { id, userId } });
    }

    if (!bon) {
      return res
        .status(404)
        .json({ message: "Bon not found or you do not have permission" });
    }

    await bon.destroy();
    res.status(204).json({ message: "Bon deleted successfully" }); // 204 No Content
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error deleting bon", error: err.message });
  }
};
