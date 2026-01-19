-- CreateTable
CREATE TABLE "user_master" (
    "user_id" UUID NOT NULL,
    "user_name" VARCHAR(255) NOT NULL,
    "user_password" VARCHAR(255) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_deleted" BOOLEAN NOT NULL DEFAULT false,
    "is_appvd" BOOLEAN NOT NULL DEFAULT false,
    "sync_date" TIMESTAMPTZ(6),
    "created_date" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modified_date" TIMESTAMPTZ(6) NOT NULL,
    "device_type" VARCHAR(100),
    "device_id" VARCHAR(255),

    CONSTRAINT "user_master_pkey" PRIMARY KEY ("user_id")
);
