// @prisma/client 是 CommonJS，在 ESM 下需用默认导入
import pkg from '@prisma/client'
import type { Prisma } from '@prisma/client'
const { PrismaClient } = pkg

// 防止热重载或多次import导致多实例
type DBInstance = InstanceType<typeof PrismaClient>

const globalForPrisma = globalThis as unknown as { prisma?: DBInstance }

export const DB: DBInstance =
  globalForPrisma.prisma ??
  new PrismaClient()

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = DB

export const DBTransaction = async <T>(
  callback: (prisma: Prisma.TransactionClient) => Promise<T>,
): Promise<T> => {
  return DB.$transaction(callback)
}