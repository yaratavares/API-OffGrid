/*
  Warnings:

  - You are about to drop the `servicesUsers` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `cnpj` to the `companies` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "servicesUsers" DROP CONSTRAINT "servicesUsers_clientId_fkey";

-- DropForeignKey
ALTER TABLE "servicesUsers" DROP CONSTRAINT "servicesUsers_serviceId_fkey";

-- AlterTable
ALTER TABLE "companies" ADD COLUMN     "cnpj" TEXT NOT NULL;

-- DropTable
DROP TABLE "servicesUsers";

-- CreateTable
CREATE TABLE "servicesClients" (
    "id" SERIAL NOT NULL,
    "clientId" INTEGER NOT NULL,
    "serviceId" INTEGER NOT NULL,

    CONSTRAINT "servicesClients_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "servicesClients" ADD CONSTRAINT "servicesClients_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "clients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "servicesClients" ADD CONSTRAINT "servicesClients_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "services"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
