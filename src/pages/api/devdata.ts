import type { NextApiRequest, NextApiResponse } from "next";
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

type ResponseData = {
  message: string;
};

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  if (req.method === "POST") {
    const test = await prisma.prescription.create({
      data: {
        medications: {
          create: [
            {
              dosage: 1,
              strength: 400,
              name: "Algifor-L forte 400",
              frequency: "1111",
              taken: "1111",
            },
          ],
        },
        start: new Date(),
        end: new Date(),
        description: "",
        doctor: {
          create: [
            {
              name: "Cornelia Wirz",
              adress: "Guisanplatz, 2503 Biel",
              mail: "cornelia@wirz.ch",
              phone: "who cares",
            },
          ],
        },
      },
    });

    console.log(test);

    res.status(200).send({ message: JSON.stringify(test) });
  } else if (req.method === "GET") {
    const test = await prisma.prescription.findUnique({
      where: {
        id: "64e9cc081c3fc966b4d3ca7f",
      },
      include: {
        medications: true,
      },
    });

    res.status(200).send({ message: JSON.stringify(test) });
  }
}
