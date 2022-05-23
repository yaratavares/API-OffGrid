import { Request, Response } from "express";
import { Companies } from "@prisma/client";

async function signUp(req: Request, res: Response) {
  const user: Companies = req.body;

  //await authService.insertNewUser(user);

  res.sendStatus(201);
}

export {signUp}