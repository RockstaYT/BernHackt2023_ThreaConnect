import type { NextApiRequest, NextApiResponse } from "next";
import { Medication, Prescription, PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

type ResponseData = {
  message: string;
};

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Prescription[]>
) {
  if (req.method === "POST") {
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
