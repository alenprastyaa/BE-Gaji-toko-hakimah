const jwt = require("jsonwebtoken");
require("dotenv").config();

const auth = (roles = []) => {
  if (typeof roles === "string") {
    roles = [roles];
  }

  return (req, res, next) => {
    const token = req.header("Authorization")?.replace("Bearer ", "");
    if (!token) {
      return res
        .status(401)
        .json({ message: "No token, authorization denied" });
    }
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = decoded;
      if (roles.length && !roles.includes(req.user.role)) {
        return res
          .status(403)
          .json({ message: "Forbidden: You do not have the necessary role" });
      }
      next();
    } catch (err) {
      res.status(401).json({ message: "Token is not valid" });
    }
  };
};

module.exports = auth;
