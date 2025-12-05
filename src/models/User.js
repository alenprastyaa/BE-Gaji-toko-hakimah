// models/User.js - Updated with explicit table naming
const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const bcrypt = require("bcryptjs");

const User = sequelize.define(
  "User",
  {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    status: {
      type: DataTypes.STRING,
      defaultValue: "active"
    },
    username: {
      type: DataTypes.STRING,
      allowNull: true,
      // unique: true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    role: {
      type: DataTypes.ENUM("karyawan", "admin"),
      defaultValue: "karyawan",
    },
    namaLengkap: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    tanggalMasukKerja: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },
    gaji: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: true,
      defaultValue: 0.0,
    },
  },
  {
    hooks: {
      beforeCreate: async (user) => {
        user.password = await bcrypt.hash(user.password, 10);
      },
      beforeUpdate: async (user) => {
        if (user.changed("password")) {
          user.password = await bcrypt.hash(user.password, 10);
        }
      },
    },
    tableName: "users",
    freezeTableName: true,
    timestamps: true,
  }
);

User.prototype.isValidPassword = async function (password) {
  return await bcrypt.compare(password, this.password);
};

module.exports = User;
