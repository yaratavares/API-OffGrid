import { Clients } from "@prisma/client";
import client from "../database.js";

export type ClientWithoutId = Omit<Clients, "id">;

function insert(newUser: ClientWithoutId) {
  return client.clients.create({
    data: newUser,
  });
}

function findByEmail(email: string) {
  return client.clients.findFirst({ where: { email } });
}

export default { insert, findByEmail };
