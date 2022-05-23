import { SessionClients } from "@prisma/client";
import client from "../database.js";

function findByUserId(clientId: number) {
  return client.sessionClients.findFirst({ where: { clientId } });
}

function create(newSession: SessionClients) {
  return client.sessionClients.create({ data: newSession });
}

function update(session: SessionClients, token: string) {
  return client.sessionClients.update({
    where: { clientId_token: { clientId: session.clientId, token: session.token } },
    data: { token },
  });
}

function findByToken(token: string) {
  return client.sessionClients.findFirst({ where: { token } });
}

export default { findByUserId, create, update, findByToken };
