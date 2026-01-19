/*
  Warnings:

  - You are about to drop the column `is_appvd` on the `user_master` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "user_master" DROP COLUMN "is_appvd",
ADD COLUMN     "is_approoved" BOOLEAN NOT NULL DEFAULT false;
