-- CreateTable
CREATE TABLE "company_master" (
    "company_id" UUID NOT NULL,
    "company_name" TEXT,
    "company_short" TEXT,
    "company_addr1" TEXT,
    "company_addr2" TEXT,
    "company_addr3" TEXT,
    "company_mobile" TEXT,
    "company_email" TEXT,
    "company_notes" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "company_master_pkey" PRIMARY KEY ("company_id")
);

-- CreateTable
CREATE TABLE "branch_master" (
    "branch_comp_id" UUID NOT NULL,
    "branch_id" UUID NOT NULL,
    "branch_name" TEXT,
    "branch_short" TEXT,
    "branch_addr1" TEXT,
    "branch_addr2" TEXT,
    "branch_addr3" TEXT,
    "branch_mobile" TEXT,
    "branch_email" TEXT,
    "branch_notes" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,
    "device_type" TEXT,
    "device_id" TEXT,

    CONSTRAINT "branch_master_pkey" PRIMARY KEY ("branch_id")
);

-- CreateIndex
CREATE INDEX "branch_master_branch_comp_id_idx" ON "branch_master"("branch_comp_id");

-- AddForeignKey
ALTER TABLE "branch_master" ADD CONSTRAINT "branch_master_branch_comp_id_fkey" FOREIGN KEY ("branch_comp_id") REFERENCES "company_master"("company_id") ON DELETE RESTRICT ON UPDATE CASCADE;
