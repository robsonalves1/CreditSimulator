-- CreateTable
CREATE TABLE "simulations" (
    "id" TEXT NOT NULL,
    "clientDocument" TEXT NOT NULL,
    "principalAmount" DECIMAL(12,2) NOT NULL,
    "amortizationType" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "simulations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "installments" (
    "id" TEXT NOT NULL,
    "simulationId" TEXT NOT NULL,
    "period" INTEGER NOT NULL,
    "installmentValue" DECIMAL(12,2) NOT NULL,
    "amortization" DECIMAL(12,2) NOT NULL,
    "interest" DECIMAL(12,2) NOT NULL,
    "balance" DECIMAL(12,2) NOT NULL,

    CONSTRAINT "installments_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "installments" ADD CONSTRAINT "installments_simulationId_fkey" FOREIGN KEY ("simulationId") REFERENCES "simulations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
