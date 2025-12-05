// models/Cuti.js
const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const User = require("./User");

const Cuti = sequelize.define(
  "Cuti",
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    userId: {
      type: DataTypes.UUID,
      allowNull: false,
      references: {
        model: "Users",
        key: "id",
      },
    },
    tanggalMulai: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    tanggalSelesai: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    jenisCuti: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    keperluan: {
      type: DataTypes.TEXT,
    },
    disetujui: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
  },
  {
    tableName: "cutis",
    timestamps: true,
  }
);
Cuti.belongsTo(User, { as: "pemohon", foreignKey: "userId" });


module.exports = Cuti;
