const Cuti = require("../models/Cuti");
const User = require("../models/User");
const { Op } = require("sequelize");
const { v4: uuidv4 } = require("uuid");

const cutiController = {
  async getAllCuti(req, res) {
    try {
      const whereCondition = {};
      if (req.query.status) whereCondition.disetujui = req.query.status === "true";
      if (req.query.jenisCuti) whereCondition.jenisCuti = req.query.jenisCuti;
      if (req.query.userId) whereCondition.userId = req.query.userId;
      const userWhere = {};
      if (req.query.userStatus) userWhere.status = req.query.userStatus;
      const { count, rows: cutis } = await Cuti.findAndCountAll({
        where: whereCondition,
        include: {
          model: User,
          as: "pemohon",
          where: userWhere,
          attributes: [
            "id",
            "username",
            "namaLengkap",
            "role",
            "tanggalMasukKerja",
            "status"
          ],
        },
        order: [["tanggalMulai", "DESC"]],
      });

      res.status(200).json({
        success: true,
        data: { cutis },
        message: "Data cuti berhasil diambil",
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server",
        error: error.message,
      });
    }
  },


  // Mendapatkan cuti berdasarkan ID (Admin Only) - DIPERBAIKI
  async getCutiById(req, res) {
    try {
      const { id } = req.params;

      // Validasi UUID format
      if (!id || id.length !== 36) {
        return res.status(400).json({
          success: false,
          message: "Format ID tidak valid",
        });
      }

      const cuti = await Cuti.findByPk(id, {
        include: {
          model: User,
          as: "pemohon",
          attributes: ["id", "username", "namaLengkap", "email", "jabatan"],
        },
      });

      if (!cuti) {
        return res.status(404).json({
          success: false,
          message: "Cuti tidak ditemukan.",
        });
      }

      res.status(200).json({
        success: true,
        data: { cuti },
        message: "Data cuti berhasil diambil",
      });
    } catch (error) {
      console.error("Error in getCutiById:", error);
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server saat mengambil data cuti.",
        error:
          process.env.NODE_ENV === "development"
            ? error.message
            : "Internal server error",
      });
    }
  },

  async getMyCuti(req, res) {
    try {
      const userId = req.user.id; // Dari middleware auth
      const { page = 1, limit = 10, status, jenisCuti, year } = req.query;
      const offset = (page - 1) * limit;

      // Build where condition
      const whereCondition = { userId };
      if (status) whereCondition.disetujui = status === "true";
      if (jenisCuti) whereCondition.jenisCuti = jenisCuti;

      // Filter berdasarkan tahun
      if (year) {
        whereCondition.tanggalMulai = {
          [Op.between]: [new Date(`${year}-01-01`), new Date(`${year}-12-31`)],
        };
      }

      const { count, rows: cutis } = await Cuti.findAndCountAll({
        where: whereCondition,
        include: {
          model: User,
          as: "pemohon",
          attributes: ["id", "username", "namaLengkap"],
        },
        order: [["tanggalMulai", "DESC"]],
        limit: parseInt(limit),
        offset: parseInt(offset),
      });

      // Hitung statistik cuti user
      const totalCutiTahunIni = await Cuti.count({
        where: {
          userId,
          tanggalMulai: {
            [Op.between]: [
              new Date(`${new Date().getFullYear()}-01-01`),
              new Date(`${new Date().getFullYear()}-12-31`),
            ],
          },
        },
      });

      const cutiDisetujui = await Cuti.count({
        where: {
          userId,
          disetujui: true,
          tanggalMulai: {
            [Op.between]: [
              new Date(`${new Date().getFullYear()}-01-01`),
              new Date(`${new Date().getFullYear()}-12-31`),
            ],
          },
        },
      });

      const totalPages = Math.ceil(count / limit);

      res.status(200).json({
        success: true,
        data: {
          cutis,
          statistics: {
            totalCutiTahunIni,
            cutiDisetujui,
            cutiMenungguPersetujuan: totalCutiTahunIni - cutiDisetujui,
          },
          pagination: {
            currentPage: parseInt(page),
            totalPages,
            totalItems: count,
            itemsPerPage: parseInt(limit),
            hasNextPage: page < totalPages,
            hasPrevPage: page > 1,
          },
        },
        message: "Data cuti Anda berhasil diambil",
      });
    } catch (error) {
      console.error("Error in getMyCuti:", error);
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server saat mengambil data cuti.",
        error:
          process.env.NODE_ENV === "development"
            ? error.message
            : "Internal server error",
      });
    }
  },

  // BARU: Mendapatkan detail cuti milik user yang sedang login
  async getMyCutiById(req, res) {
    try {
      const { id } = req.params;
      const userId = req.user.id;

      // Validasi UUID format
      if (!id || id.length !== 36) {
        return res.status(400).json({
          success: false,
          message: "Format ID tidak valid",
        });
      }

      const cuti = await Cuti.findOne({
        where: {
          id,
          userId, // Pastikan hanya bisa akses cuti milik sendiri
        },
        include: {
          model: User,
          as: "pemohon",
          attributes: ["id", "username", "namaLengkap", "email"],
        },
      });

      if (!cuti) {
        return res.status(404).json({
          success: false,
          message: "Cuti tidak ditemukan atau Anda tidak memiliki akses.",
        });
      }

      res.status(200).json({
        success: true,
        data: { cuti },
        message: "Detail cuti berhasil diambil",
      });
    } catch (error) {
      console.error("Error in getMyCutiById:", error);
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server saat mengambil detail cuti.",
        error:
          process.env.NODE_ENV === "development"
            ? error.message
            : "Internal server error",
      });
    }
  },

  // Menambahkan cuti baru (Admin Only)
  async createCuti(req, res) {
    try {
      const { userId, tanggalMulai, tanggalSelesai, jenisCuti, keperluan } =
        req.body;

      if (!userId || !tanggalMulai || !tanggalSelesai || !jenisCuti) {
        return res.status(400).json({
          success: false,
          message:
            "Mohon lengkapi semua field yang diperlukan (User, Tanggal Mulai, Tanggal Selesai, Jenis Cuti).",
        });
      }

      // Validasi user exists
      const user = await User.findByPk(userId);
      if (!user) {
        return res.status(404).json({
          success: false,
          message: "User tidak ditemukan",
        });
      }

      // Validasi tanggal
      const startDate = new Date(tanggalMulai);
      const endDate = new Date(tanggalSelesai);
      const today = new Date();

      if (startDate > endDate) {
        return res.status(400).json({
          success: false,
          message: "Tanggal mulai tidak boleh setelah tanggal selesai.",
        });
      }

      //   if (startDate < today.setHours(0, 0, 0, 0)) {
      //     return res.status(400).json({
      //       success: false,
      //       message: "Tanggal mulai tidak boleh di masa lalu.",
      //     });
      //   }

      // Cek overlap cuti
      const overlappingCuti = await Cuti.findOne({
        where: {
          userId,
          [Op.or]: [
            {
              tanggalMulai: {
                [Op.between]: [tanggalMulai, tanggalSelesai],
              },
            },
            {
              tanggalSelesai: {
                [Op.between]: [tanggalMulai, tanggalSelesai],
              },
            },
            {
              [Op.and]: [
                { tanggalMulai: { [Op.lte]: tanggalMulai } },
                { tanggalSelesai: { [Op.gte]: tanggalSelesai } },
              ],
            },
          ],
        },
      });

      if (overlappingCuti) {
        return res.status(400).json({
          success: false,
          message: "Sudah ada pengajuan cuti pada rentang tanggal tersebut.",
        });
      }

      const newCuti = await Cuti.create({
        id: uuidv4(),
        userId,
        tanggalMulai,
        tanggalSelesai,
        jenisCuti,
        keperluan,
        disetujui: false,
      });

      const createdCutiWithKaryawan = await Cuti.findByPk(newCuti.id, {
        include: {
          model: User,
          as: "pemohon",
          attributes: ["id", "username", "namaLengkap"],
        },
      });

      res.status(201).json({
        success: true,
        data: { cuti: createdCutiWithKaryawan },
        message: "Cuti berhasil ditambahkan.",
      });
    } catch (error) {
      console.error("Error in createCuti:", error);
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server saat menambahkan cuti.",
        error:
          process.env.NODE_ENV === "development"
            ? error.message
            : "Internal server error",
      });
    }
  },

  // BARU: User mengajukan cuti sendiri
  async createMyCuti(req, res) {
    try {
      const userId = req.user.id;
      const { tanggalMulai, tanggalSelesai, jenisCuti, keperluan } = req.body;

      if (!tanggalMulai || !tanggalSelesai || !jenisCuti) {
        return res.status(400).json({
          success: false,
          message:
            "Mohon lengkapi semua field yang diperlukan (Tanggal Mulai, Tanggal Selesai, Jenis Cuti).",
        });
      }

      // Validasi tanggal
      const startDate = new Date(tanggalMulai);
      const endDate = new Date(tanggalSelesai);
      const today = new Date();

      if (startDate > endDate) {
        return res.status(400).json({
          success: false,
          message: "Tanggal mulai tidak boleh setelah tanggal selesai.",
        });
      }

      if (startDate < today.setHours(0, 0, 0, 0)) {
        return res.status(400).json({
          success: false,
          message: "Tanggal mulai tidak boleh di masa lalu.",
        });
      }

      // Cek overlap cuti
      const overlappingCuti = await Cuti.findOne({
        where: {
          userId,
          [Op.or]: [
            {
              tanggalMulai: {
                [Op.between]: [tanggalMulai, tanggalSelesai],
              },
            },
            {
              tanggalSelesai: {
                [Op.between]: [tanggalMulai, tanggalSelesai],
              },
            },
            {
              [Op.and]: [
                { tanggalMulai: { [Op.lte]: tanggalMulai } },
                { tanggalSelesai: { [Op.gte]: tanggalSelesai } },
              ],
            },
          ],
        },
      });

      if (overlappingCuti) {
        return res.status(400).json({
          success: false,
          message:
            "Anda sudah memiliki pengajuan cuti pada rentang tanggal tersebut.",
        });
      }

      const newCuti = await Cuti.create({
        id: uuidv4(),
        userId,
        tanggalMulai,
        tanggalSelesai,
        jenisCuti,
        keperluan,
        disetujui: false,
      });

      const createdCutiWithKaryawan = await Cuti.findByPk(newCuti.id, {
        include: {
          model: User,
          as: "pemohon",
          attributes: ["id", "username", "namaLengkap"],
        },
      });

      res.status(201).json({
        success: true,
        data: { cuti: createdCutiWithKaryawan },
        message: "Pengajuan cuti berhasil disubmit dan menunggu persetujuan.",
      });
    } catch (error) {
      console.error("Error in createMyCuti:", error);
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server saat mengajukan cuti.",
        error:
          process.env.NODE_ENV === "development"
            ? error.message
            : "Internal server error",
      });
    }
  },

  async updateCuti(req, res) {
    try {
      const { id } = req.params;
      const {
        userId,
        tanggalMulai,
        tanggalSelesai,
        jenisCuti,
        keperluan,
        disetujui,
      } = req.body;

      const cuti = await Cuti.findByPk(id);
      if (!cuti) {
        return res.status(404).json({
          success: false,
          message: "Cuti tidak ditemukan.",
        });
      }

      // Validasi tanggal jika diubah
      if (tanggalMulai && tanggalSelesai) {
        const startDate = new Date(tanggalMulai);
        const endDate = new Date(tanggalSelesai);
        if (startDate > endDate) {
          return res.status(400).json({
            success: false,
            message: "Tanggal mulai tidak boleh setelah tanggal selesai.",
          });
        }
      }

      await cuti.update({
        userId: userId || cuti.userId,
        tanggalMulai: tanggalMulai || cuti.tanggalMulai,
        tanggalSelesai: tanggalSelesai || cuti.tanggalSelesai,
        jenisCuti: jenisCuti || cuti.jenisCuti,
        keperluan: keperluan || cuti.keperluan,
        disetujui: disetujui !== undefined ? disetujui : cuti.disetujui,
      });

      const updatedCutiWithKaryawan = await Cuti.findByPk(cuti.id, {
        include: {
          model: User,
          as: "pemohon",
          attributes: ["id", "username", "namaLengkap"],
        },
      });

      res.status(200).json({
        success: true,
        data: { cuti: updatedCutiWithKaryawan },
        message: "Cuti berhasil diperbarui.",
      });
    } catch (error) {
      console.error("Error in updateCuti:", error);
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server saat memperbarui cuti.",
        error:
          process.env.NODE_ENV === "development"
            ? error.message
            : "Internal server error",
      });
    }
  },

  // BARU: Approve/Reject cuti
  async approveCuti(req, res) {
    try {
      const { id } = req.params;
      const { disetujui, catatanAdmin } = req.body;

      if (disetujui === undefined) {
        return res.status(400).json({
          success: false,
          message: "Status persetujuan harus diisi (true/false)",
        });
      }

      const cuti = await Cuti.findByPk(id);
      if (!cuti) {
        return res.status(404).json({
          success: false,
          message: "Cuti tidak ditemukan.",
        });
      }

      await cuti.update({
        disetujui,
        catatanAdmin,
        tanggalDisetujui: new Date(),
      });

      const updatedCutiWithKaryawan = await Cuti.findByPk(cuti.id, {
        include: {
          model: User,
          as: "pemohon",
          attributes: ["id", "username", "namaLengkap", "email"],
        },
      });

      res.status(200).json({
        success: true,
        data: { cuti: updatedCutiWithKaryawan },
        message: `Cuti berhasil ${disetujui ? "disetujui" : "ditolak"}.`,
      });
    } catch (error) {
      console.error("Error in approveCuti:", error);
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server saat memproses persetujuan cuti.",
        error:
          process.env.NODE_ENV === "development"
            ? error.message
            : "Internal server error",
      });
    }
  },

  // Menghapus cuti (Admin Only)
  async deleteCuti(req, res) {
    try {
      const { id } = req.params;
      const cuti = await Cuti.findByPk(id);
      if (!cuti) {
        return res.status(404).json({
          success: false,
          message: "Cuti tidak ditemukan.",
        });
      }
      await cuti.destroy();
      res.status(200).json({
        success: true,
        message: "Cuti berhasil dihapus.",
      });
    } catch (error) {
      console.error("Error in deleteCuti:", error);
      res.status(500).json({
        success: false,
        message: "Terjadi kesalahan server saat menghapus cuti.",
        error:
          process.env.NODE_ENV === "development"
            ? error.message
            : "Internal server error",
      });
    }
  },
};

module.exports = cutiController;
