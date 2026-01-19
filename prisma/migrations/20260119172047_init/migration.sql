-- CreateTable
CREATE TABLE "loan_companies" (
    "loan_comp_id" UUID NOT NULL,
    "loan_comp_name" TEXT,
    "loan_comp_short" TEXT,
    "loan_comp_notes" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,
    "device_type" TEXT,
    "device_id" TEXT,

    CONSTRAINT "loan_companies_pkey" PRIMARY KEY ("loan_comp_id")
);

-- CreateTable
CREATE TABLE "ledger_group_master" (
    "group_id" UUID NOT NULL,
    "group_name" TEXT,
    "group_type" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "ledger_group_master_pkey" PRIMARY KEY ("group_id")
);

-- CreateTable
CREATE TABLE "ledger_master" (
    "ledger_id" UUID NOT NULL,
    "ledger_group_id" UUID NOT NULL,
    "ledger_loan_comp_id" UUID,
    "ledger_name" TEXT,
    "ledger_addr1" TEXT,
    "ledger_addr2" TEXT,
    "ledger_addr3" TEXT,
    "ledger_mobile" TEXT,
    "ledger_wapp" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,
    "device_type" TEXT,
    "device_id" TEXT,

    CONSTRAINT "ledger_master_pkey" PRIMARY KEY ("ledger_id")
);

-- CreateTable
CREATE TABLE "denom_master" (
    "denom_id" INTEGER NOT NULL,
    "denom_value" TEXT,
    "denom_position" INTEGER,
    "denom_count" BIGINT,
    "denom_active" BOOLEAN NOT NULL DEFAULT true,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,
    "device_type" TEXT,
    "device_id" TEXT,

    CONSTRAINT "denom_master_pkey" PRIMARY KEY ("denom_id")
);

-- CreateTable
CREATE TABLE "voucher_types" (
    "type_id" INTEGER NOT NULL,
    "type_name" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "voucher_types_pkey" PRIMARY KEY ("type_id")
);

-- CreateTable
CREATE TABLE "voucher_txn" (
    "vchr_txn_id" UUID NOT NULL,
    "vchr_txn_date" TIMESTAMPTZ(6),
    "vchr_txn_type" INTEGER,
    "vchr_txn_from_id" UUID,
    "vchr_txn_to_id" UUID,
    "vchr_txn_amount" DECIMAL(18,2),
    "vchr_txn_notes" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,
    "device_type" TEXT,
    "device_id" TEXT,

    CONSTRAINT "voucher_txn_pkey" PRIMARY KEY ("vchr_txn_id")
);

-- CreateTable
CREATE TABLE "ledger_txn" (
    "lgr_txn_id" UUID NOT NULL,
    "lgr_vchr_txn_id" UUID,
    "lgr_txn_date" TIMESTAMPTZ(6),
    "lgr_txn_type" INTEGER,
    "lgr_from_id" UUID,
    "lgr_to_id" UUID,
    "lgr_txn_amt" DECIMAL(18,2),
    "lgr_txn_crdr" TEXT,
    "lgr_txn_notes" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "ledger_txn_pkey" PRIMARY KEY ("lgr_txn_id")
);

-- CreateTable
CREATE TABLE "denom_txn" (
    "denom_txn_id" UUID NOT NULL,
    "vchr_txn_id" UUID,
    "vchr_txn_type" INTEGER,
    "denom_id" INTEGER,
    "denom_count" INTEGER,
    "denom_value" DECIMAL(18,2),
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "denom_txn_pkey" PRIMARY KEY ("denom_txn_id")
);

-- CreateTable
CREATE TABLE "billing_txn" (
    "bill_id" UUID NOT NULL,
    "bill_date" TIMESTAMPTZ(6),
    "user_id" UUID,
    "agent_id" UUID,
    "agent_mode" TEXT,
    "loan_comp_id" UUID,
    "payment_mode" TEXT,
    "billed_ledger_id" UUID,
    "bill_amount" DECIMAL(18,2),
    "credit_amt" DECIMAL(18,2),
    "bill_notes" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "billing_txn_pkey" PRIMARY KEY ("bill_id")
);

-- CreateIndex
CREATE INDEX "ledger_master_ledger_group_id_idx" ON "ledger_master"("ledger_group_id");

-- CreateIndex
CREATE INDEX "ledger_master_ledger_loan_comp_id_idx" ON "ledger_master"("ledger_loan_comp_id");

-- CreateIndex
CREATE INDEX "voucher_txn_vchr_txn_type_idx" ON "voucher_txn"("vchr_txn_type");

-- CreateIndex
CREATE INDEX "voucher_txn_vchr_txn_from_id_idx" ON "voucher_txn"("vchr_txn_from_id");

-- CreateIndex
CREATE INDEX "voucher_txn_vchr_txn_to_id_idx" ON "voucher_txn"("vchr_txn_to_id");

-- CreateIndex
CREATE INDEX "ledger_txn_lgr_vchr_txn_id_idx" ON "ledger_txn"("lgr_vchr_txn_id");

-- CreateIndex
CREATE INDEX "ledger_txn_lgr_txn_type_idx" ON "ledger_txn"("lgr_txn_type");

-- CreateIndex
CREATE INDEX "ledger_txn_lgr_from_id_idx" ON "ledger_txn"("lgr_from_id");

-- CreateIndex
CREATE INDEX "ledger_txn_lgr_to_id_idx" ON "ledger_txn"("lgr_to_id");

-- CreateIndex
CREATE INDEX "denom_txn_vchr_txn_id_idx" ON "denom_txn"("vchr_txn_id");

-- CreateIndex
CREATE INDEX "denom_txn_vchr_txn_type_idx" ON "denom_txn"("vchr_txn_type");

-- CreateIndex
CREATE INDEX "denom_txn_denom_id_idx" ON "denom_txn"("denom_id");

-- CreateIndex
CREATE INDEX "billing_txn_loan_comp_id_idx" ON "billing_txn"("loan_comp_id");

-- CreateIndex
CREATE INDEX "billing_txn_billed_ledger_id_idx" ON "billing_txn"("billed_ledger_id");

-- AddForeignKey
ALTER TABLE "ledger_master" ADD CONSTRAINT "ledger_master_ledger_group_id_fkey" FOREIGN KEY ("ledger_group_id") REFERENCES "ledger_group_master"("group_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger_master" ADD CONSTRAINT "ledger_master_ledger_loan_comp_id_fkey" FOREIGN KEY ("ledger_loan_comp_id") REFERENCES "loan_companies"("loan_comp_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "voucher_txn" ADD CONSTRAINT "voucher_txn_vchr_txn_type_fkey" FOREIGN KEY ("vchr_txn_type") REFERENCES "voucher_types"("type_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "voucher_txn" ADD CONSTRAINT "voucher_txn_vchr_txn_from_id_fkey" FOREIGN KEY ("vchr_txn_from_id") REFERENCES "ledger_master"("ledger_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "voucher_txn" ADD CONSTRAINT "voucher_txn_vchr_txn_to_id_fkey" FOREIGN KEY ("vchr_txn_to_id") REFERENCES "ledger_master"("ledger_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger_txn" ADD CONSTRAINT "ledger_txn_lgr_vchr_txn_id_fkey" FOREIGN KEY ("lgr_vchr_txn_id") REFERENCES "voucher_txn"("vchr_txn_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger_txn" ADD CONSTRAINT "ledger_txn_lgr_txn_type_fkey" FOREIGN KEY ("lgr_txn_type") REFERENCES "voucher_types"("type_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger_txn" ADD CONSTRAINT "ledger_txn_lgr_from_id_fkey" FOREIGN KEY ("lgr_from_id") REFERENCES "ledger_master"("ledger_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ledger_txn" ADD CONSTRAINT "ledger_txn_lgr_to_id_fkey" FOREIGN KEY ("lgr_to_id") REFERENCES "ledger_master"("ledger_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "denom_txn" ADD CONSTRAINT "denom_txn_vchr_txn_id_fkey" FOREIGN KEY ("vchr_txn_id") REFERENCES "voucher_txn"("vchr_txn_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "denom_txn" ADD CONSTRAINT "denom_txn_vchr_txn_type_fkey" FOREIGN KEY ("vchr_txn_type") REFERENCES "voucher_types"("type_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "denom_txn" ADD CONSTRAINT "denom_txn_denom_id_fkey" FOREIGN KEY ("denom_id") REFERENCES "denom_master"("denom_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "billing_txn" ADD CONSTRAINT "billing_txn_loan_comp_id_fkey" FOREIGN KEY ("loan_comp_id") REFERENCES "loan_companies"("loan_comp_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "billing_txn" ADD CONSTRAINT "billing_txn_billed_ledger_id_fkey" FOREIGN KEY ("billed_ledger_id") REFERENCES "ledger_master"("ledger_id") ON DELETE SET NULL ON UPDATE CASCADE;
