const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const User = require("./User");

const Bon = sequelize.define(
  "Bon",
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    tanggal: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    jumlahBon: {
      type: DataTypes.DECIMAL(10, 2), // Contoh: 12345678.99
      allowNull: false,
    },
    keperluan: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    userId: {
      // Foreign Key untuk menghubungkan bon dengan karyawan
      type: DataTypes.UUID,
      allowNull: true,
      references: {
        model: User, // Merujuk ke tabel Users
        key: "id",
      },
      allowNull: false,
    },
  },
  {
    tableName: "bons", // Good practice to explicitly set table name
    timestamps: true,
  }
);

Bon.belongsTo(User, { foreignKey: "userId", as: "karyawan" });
User.hasMany(Bon, { foreignKey: "userId", as: "bons" });

module.exports = Bon;
