import { Clients } from "@prisma/client";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

import authRepository from "../repositories/authClientRepository.js";
import sessionRepository from "../repositories/sessionClientRepository.js";
import errors from "../utils/errorUtils.js";

async function insertNewUser(newUser: Clients) {
  const user = await authRepository.findByEmail(newUser.email);

  if (user) {
    throw errors.conflict();
  }

  const passwordHash = bcrypt.hashSync(newUser.password, 10);

  const userObject: Clients = { ...newUser, password: passwordHash };

  await authRepository.insert(userObject);
}

async function createSession(logUser: Clients) {
  const user = await authRepository.findByEmail(logUser.email);

  if (!user) {
    throw errors.notFound();
  }

  if (!bcrypt.compareSync(logUser.password, user.password)) {
    throw errors.unauthorized();
  }

  const token = verifyOrCreateSession(user);

  return token;
}

export async function verifyOrCreateSession(user: Clients) {
  const session = await sessionRepository.findByUserId(user.id);

  const secretKey = process.env.JWT_SECRET;
  const token = jwt.sign({ email: user.email }, secretKey);

  if (session) {
    await sessionRepository.update(session, token);

    return token;
  }

  await sessionRepository.create({ clientId: user.id, token });
  return token;
}

export async function verifyToken(token: string) {
  const session = await sessionRepository.findByToken(token);

  if (!session) {
    throw errors.unauthorized();
  }

  try {
    const secretKey = process.env.JWT_SECRET;
    jwt.verify(token, secretKey);
  } catch (err) {
    throw errors.unauthorized();
  }

  return session.clientId;
}

export default { createSession, insertNewUser };
