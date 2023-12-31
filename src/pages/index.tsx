import Head from "next/head";
import Link from "next/link";
//import { useRouter } from "next/router";
import { Dialog, Transition } from "@headlessui/react";
import { Fragment, useState } from "react";

export default function Home() {
  return (
    <>
      <Head>
        <title>Create T3 App</title>
        <meta name="description" content="Generated by create-t3-app" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <Nav></Nav>

      <main className=" px-16">
        <div className="flex">
          <TherapyInfos></TherapyInfos>
        </div>
      </main>
      {/*<main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c]">
        <div className="container flex flex-col items-center justify-center gap-12 px-4 py-16 ">
          <h1 className="text-5xl font-extrabold tracking-tight text-white sm:text-[5rem]">
            Create <span className="text-[hsl(280,100%,70%)]">T3</span> App
          </h1>
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 md:gap-8">
            <Link
              className="flex max-w-xs flex-col gap-4 rounded-xl bg-white/10 p-4 text-white hover:bg-white/20"
              href="https://create.t3.gg/en/usage/first-steps"
              target="_blank"
            >
              <h3 className="text-2xl font-bold">First Steps →</h3>
              <div className="text-lg">
                Just the basics - Everything you need to know to set up your
                database and authentication.
              </div>
            </Link>
            <Link
              className="flex max-w-xs flex-col gap-4 rounded-xl bg-white/10 p-4 text-white hover:bg-white/20"
              href="https://create.t3.gg/en/introduction"
              target="_blank"
            >
              <h3 className="text-2xl font-bold">Documentation →</h3>
              <div className="text-lg">
                Learn more about Create T3 App, the libraries it uses, and how
                to deploy it.
              </div>
            </Link>
          </div>
        </div>
      </main>*/}
    </>
  );
}

function Nav() {
  return (
    <div>
      <Link href="#">Test</Link>
    </div>
  );
}

function TherapyInfos() {
  interface TherapyInfo {
    title: string;
    subtitle: string;
    date: Date;
    info: string;
    done: boolean;
    doneText: string;
    medications?: Medication[];
  }
  interface Medication {
    name: string;
    strenght: number;
    dosage: number;
  }
  const [isOpen, setIsOpen] = useState(false);
  const [chosenTherapy, setChosenTherapy] = useState<TherapyInfo>({
    title: "",
    subtitle: "",
    date: new Date(0),
    info: "",
    done: false,
    doneText: "",
  });

  function closeModal() {
    setIsOpen(false);
    setChosenTherapy({
      title: "",
      subtitle: "",
      date: new Date(0),
      info: "",
      done: false,
      doneText: "",
    });
  }

  function openModal(therapy: TherapyInfo) {
    setIsOpen(true);
    console.log(therapy);
    setChosenTherapy(therapy);
  }

  const therapies: TherapyInfo[] = [
    {
      title: "Einnahme Medikamente",
      subtitle: "Morgen",
      date: new Date("2023-08-23T14:00:00"),
      info: "Bitte nehmen sie folgende Medikamente ein:",
      done: false,
      doneText: "Medikamente gennomen",
      medications: [
        {
          name: "Aligifor-L forte 400",
          strenght: 400,
          dosage: 1,
        },
        {
          name: "Aligifor-L forte 400",
          strenght: 400,
          dosage: 1,
        },
      ],
    },
    {
      title: "Einnahme Medikamente",
      subtitle: "Mittag",
      date: new Date("2023-08-23T14:00:00"),
      info: "",
      done: false,
      doneText: "Medikamente gennomen",
    },
    {
      title: "Einnahme Medikamente",
      subtitle: "Abend",
      date: new Date("2023-08-23T14:00:00"),
      info: "",
      done: false,
      doneText: "Medikamente gennomen",
    },
  ];

  return (
    <>
      <div className=" flex flex-col rounded-md bg-green-100 p-4 drop-shadow-lg">
        <h1 className=" text-xl font-extrabold text-stone-800">Termine:</h1>
        {therapies.map((therapy) =>
          therapy.done ? (
            <></>
          ) : (
            <div className="my-2 flex" key={therapy.title}>
              <button
                type="button"
                onClick={() => openModal(therapy)}
                className=" flex items-center justify-center rounded-md bg-green-300 p-2 text-sm"
              >
                <div className="mr-5 flex flex-col items-start justify-start">
                  <h1 className=" text-md font-bold">{therapy.title}</h1>
                  <h3 className=" text-md font-light">{therapy.subtitle}</h3>
                </div>
                <div>
                  <h2 className=" text-md font-bold">
                    {therapy.date.toDateString()}
                  </h2>
                </div>
              </button>
            </div>
          )
        )}
      </div>
      <Transition appear show={isOpen} as={Fragment}>
        <Dialog as="div" className="relative z-10" onClose={closeModal}>
          <Transition.Child
            as={Fragment}
            enter="ease-out duration-300"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="ease-in duration-200"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <div className="fixed inset-0 bg-black bg-opacity-25" />
          </Transition.Child>

          <div className="fixed inset-0 overflow-y-auto">
            <div className="flex min-h-full items-center justify-center p-4 text-center">
              <Transition.Child
                as={Fragment}
                enter="ease-out duration-300"
                enterFrom="opacity-0 scale-95"
                enterTo="opacity-100 scale-100"
                leave="ease-in duration-200"
                leaveFrom="opacity-100 scale-100"
                leaveTo="opacity-0 scale-95"
              >
                <Dialog.Panel className="w-full max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all">
                  <Dialog.Title
                    as="h3"
                    className="text-lg font-bold leading-6 text-gray-900"
                  >
                    {chosenTherapy.title}
                  </Dialog.Title>
                  <div className="mt-2">
                    <p className="text-sm text-gray-500">
                      {chosenTherapy.info}
                    </p>
                    {chosenTherapy.medications?.map(
                      (medication) => medication.name
                    )}
                  </div>

                  <div className="mt-4">
                    <button
                      type="button"
                      className="inline-flex justify-center rounded-md border border-transparent bg-blue-100 px-4 py-2 text-sm font-medium text-blue-900 hover:bg-blue-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 focus-visible:ring-offset-2"
                      onClick={closeModal}
                    >
                      {chosenTherapy.doneText}
                    </button>
                  </div>
                </Dialog.Panel>
              </Transition.Child>
            </div>
          </div>
        </Dialog>
      </Transition>
    </>
  );
}
