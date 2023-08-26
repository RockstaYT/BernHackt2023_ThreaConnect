import type { NextApiRequest, NextApiResponse } from "next";
import {
  DrMedTable,
  Medication,
  Prescription,
  PrismaClient,
} from "@prisma/client";
const prisma = new PrismaClient();

type ResponseData = {
  message: string;
};

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Prescription[]>
) {
  if (req.method === "POST") {
    /* eslint-disable  @typescript-eslint/no-explicit-any */
    const body = req.body;

    const perscription = await prisma.prescription.create({
      data: {
        medications: { create: body.medications },
        start: new Date(body.start),
        end: new Date(body.end),
        description: body.description,
        DrMedTable: { create: body.doctor },
      },
    });

    res.status(200).json([perscription]);
  } else if (req.method === "GET") {
    const prescriptions = await prisma.prescription.findMany({
      include: {
        medications: true,
      },
    });

    res.status(200).send(prescriptions);
  }
}

function addPrescription(
  start: Date,
  end: Date,
  medications: Medication[],
  doctor: any
) {
  for (const medication of medications) {
    prisma.medication;
  }
}
