/*
  Warnings:

  - You are about to drop the column `userId` on the `messages` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `servicesUsers` table. All the data in the column will be lost.
  - You are about to drop the `sessions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `clientId` to the `messages` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `servicesUsers` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "messages" DROP CONSTRAINT "messages_userId_fkey";

-- DropForeignKey
ALTER TABLE "servicesUsers" DROP CONSTRAINT "servicesUsers_userId_fkey";

-- DropForeignKey
ALTER TABLE "sessions" DROP CONSTRAINT "sessions_userId_fkey";

-- AlterTable
ALTER TABLE "messages" DROP COLUMN "userId",
ADD COLUMN     "clientId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "servicesUsers" DROP COLUMN "userId",
ADD COLUMN     "clientId" INTEGER NOT NULL;

-- DropTable
DROP TABLE "sessions";

-- DropTable
DROP TABLE "users";

-- CreateTable
CREATE TABLE "clients" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "clients_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sessionClients" (
    "clientId" INTEGER NOT NULL,
    "token" TEXT NOT NULL,

    CONSTRAINT "sessionClients_pkey" PRIMARY KEY ("clientId","token")
);

-- CreateTable
CREATE TABLE "sessionCompanies" (
    "companyId" INTEGER NOT NULL,
    "token" TEXT NOT NULL,

    CONSTRAINT "sessionCompanies_pkey" PRIMARY KEY ("companyId","token")
);

-- CreateIndex
CREATE UNIQUE INDEX "clients_email_key" ON "clients"("email");

-- AddForeignKey
ALTER TABLE "sessionClients" ADD CONSTRAINT "sessionClients_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "clients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sessionCompanies" ADD CONSTRAINT "sessionCompanies_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "companies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "servicesUsers" ADD CONSTRAINT "servicesUsers_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "clients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "clients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
