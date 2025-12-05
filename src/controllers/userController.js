const User = require("../models/User");
const Bon = require("../models/Bon");
exports.getAllUsers = async (req, res) => {
  try {
    const { status } = req.query;
    const whereClause = {};
    if (status) {
      whereClause.status = status;
    }
    const users = await User.findAll({
      where: whereClause,
      attributes: [
        "id",
        "username",
        "role",
        "namaLengkap",
        "tanggalMasukKerja",
        "gaji",
        "status"
      ],
      order: [["namaLengkap", "ASC"]],
    });

    res.json(users);
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ message: "Error fetching users", error: err.message });
  }
};

exports.getUserById = async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id, {
      attributes: [
        "id",
        "username",
        "role",
        "namaLengkap",
        "tanggalMasukKerja",
        "gaji",
      ],
    });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    res.json(user);
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ message: "Error fetching user", error: err.message });
  }
};

exports.updateUser = async (req, res) => {
  const { username, role, namaLengkap, password, tanggalMasukKerja, gaji, status } =
    req.body;
  try {
    const user = await User.findByPk(req.params.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    user.username = username || user.username;
    user.status = status || user.status;
    user.role = role || user.role;
    user.namaLengkap = namaLengkap || user.namaLengkap;
    user.tanggalMasukKerja = tanggalMasukKerja || user.tanggalMasukKerja;
    user.gaji = gaji !== undefined ? gaji : user.gaji;
    if (password) {
      user.password = password;
    }
    await user.save();
    res.json({
      message: "User updated successfully",
      user: {
        id: user.id,
        status: user.status,
        username: user.username,
        role: user.role,
        namaLengkap: user.namaLengkap,
        tanggalMasukKerja: user.tanggalMasukKerja,
        gaji: user.gaji,
      },
    });
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ message: "Error updating user", error: err.message });
  }
};

exports.deleteUser = async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    await Bon.destroy({ where: { userId: user.id } });

    await user.destroy();
    res.status(204).json({ message: "User deleted successfully" });
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ message: "Error deleting user", error: err.message });
  }
};

exports.createUser = async (req, res) => {
  const { username, password, role, namaLengkap, tanggalMasukKerja, gaji } =
    req.body;
  if (!username || !password || !namaLengkap || !tanggalMasukKerja) {
    return res.status(400).json({
      message: "Username, password, full name, and start date are required.",
    });
  }
  try {
    const newUser = await User.create({
      username,
      password,
      role: role || "karyawan",
      namaLengkap,
      tanggalMasukKerja,
      gaji: gaji !== undefined ? gaji : 0.0,
    });
    res.status(201).json({
      message: "User created successfully",
      user: {
        id: newUser.id,
        username: newUser.username,
        role: newUser.role,
        namaLengkap: newUser.namaLengkap,
        tanggalMasukKerja: newUser.tanggalMasukKerja,
        gaji: newUser.gaji,
      },
    });
  } catch (err) {
    console.error(err);
    if (err.name === "SequelizeUniqueConstraintError") {
      return res.status(409).json({ message: "Username already exists." });
    }
    res
      .status(500)
      .json({ message: "Error creating user", error: err.message });
  }
};
