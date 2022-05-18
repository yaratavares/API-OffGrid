import { Router } from "express";

import authController from "../controllers/authController.js";
import validateSchemaMiddleware from "../middlewares/schemaValidateMiddleware.js";
import authSchema from "../schemas/authSchema.js";

const authClientRouter = Router();

authClientRouter.post(
  "/client/sign-up",
  validateSchemaMiddleware(authSchema),
  authController.signUp
);
authClientRouter.post(
  "/client/sign-in",
  validateSchemaMiddleware(authSchema),
  authController.signIn
);

export default authClientRouter;
