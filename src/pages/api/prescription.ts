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
    const body: Prescription = req.body;

    const medications: Medication[] = body["medications"];
    const medicationIds: any[] = [];

    const perscription = await prisma.prescription.create({
      data: {
        medications: { create: medications },
        start: new Date(body.start),
        end: new Date(body.end),
        description: body.description,
      },
    });

    /*for (const medication of medications) {
      const test = await prisma.medication.create({
        data: medication,
      });

      await prisma.prescription.update({
        where: {
          id: perscription.id,
        },
        data: {
          medications: {
            connect: {
              id: test.id,
            },
          },
        },
      });
    }**/

    console.log(await prisma.prescription.findMany());

    //res.status(200).json([perscription]);
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
