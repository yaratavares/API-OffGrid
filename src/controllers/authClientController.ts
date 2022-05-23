import { Request, Response } from "express";
import { Clients } from "@prisma/client";

import authService from "../services/authClientService.js";

async function signUp(req: Request, res: Response) {
  const user: Clients = req.body;

  await authService.insertNewUser(user);

  res.sendStatus(201);
}

async function signIn(req: Request, res: Response) {
  const user: Clients = req.body;

  const token = await authService.createSession(user);

  res.send({ token });
}

export default { signIn, signUp };
