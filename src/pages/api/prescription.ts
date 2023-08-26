import type { NextApiRequest, NextApiResponse } from "next";
import { Prescription, PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Prescription[]>
) {
  if (req.method === "POST") {
    const body = req.body;

    const perscription = await prisma.prescription.create({
      data: {
        name: body.name,
        medications: { create: body.medications },
        start: new Date(body.start),
        end: new Date(body.end),
        description: body.description,
        doctor: { create: body.doctor },
      },
    });

    res.status(200).json([perscription]);
  } else if (req.method === "GET") {
    const prescriptions = await prisma.prescription.findMany({
      include: {
        medications: true,
        doctor: true,
      },
    });

    res.status(200).send(prescriptions);
  }
}
