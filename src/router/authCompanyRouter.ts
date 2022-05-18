import { Router } from "express";

import authController from "../controllers/authController.js";
import validateSchemaMiddleware from "../middlewares/schemaValidateMiddleware.js";
import authSchema from "../schemas/authSchema.js";

const authCompanyRouter = Router();

authCompanyRouter.post(
  "/company/sign-up",
  validateSchemaMiddleware(authSchema),
  authController.signUp
);
authCompanyRouter.post(
  "/company/sign-in",
  validateSchemaMiddleware(authSchema),
  authController.signIn
);

export default authCompanyRouter;