import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
import { useRouter } from "next/router";
import { abiPlatziFoodAddress } from "../config";

import PlatziFood from "../utils/abi/PlatziFood.json";

export default function AddDish() {
  const router = useRouter();
  const [formInput, updateFormInput] = useState({
    fileUrl: "",
    name: "",
    originCountry: "",
  });

  const addDish = async ()  => {
    const { ethereum } = window; //Verify we have ethereum in the browser
    if (ethereum) { 
        const provider = new ethers.providers.Web3Provider(ethereum); //Get the provider
        const signer = provider.getSigner(); //Get the signer from the provider
        const contract = new ethers.Contract(abiPlatziFoodAddress, PlatziFood.abi, signer); //Reference to the contract and abi file. Here happens the magic. You connect the contract with the signer
        const transaction = await contract.addPlatziFood(formInput.fileUrl, formInput.name, formInput.originCountry); //Send the params of the function
        transaction.wait(); //Wait for the transaction to be executed
        router.push("/"); //Go to the application root
    }
  }


  return (
    <div className="flex justify-center">
      <div className="w-1/2 flex flex-col pb-12">
        <input
          placeholder="URL Food"
          className="mt-8 border rounded p-4"
          onChange={(e) =>
            updateFormInput({ ...formInput, fileUrl: e.target.value })
          }
        />
        <input
          placeholder="Food name"
          className="mt-2 border rounded p-4"
          onChange={(e) =>
            updateFormInput({ ...formInput, name: e.target.value })
          }
        />
        <input
          placeholder="Origin Country"
          className="mt-2 border rounded p-4"
          onChange={(e) =>
            updateFormInput({ ...formInput, originCountry: e.target.value })
          }
        />
        <button
          onClick={addDish}
          className="font-bold mt-4 bg-blue-500 text-white rounded p-4 shadow-lg"
        >
          Add food
        </button>
      </div>
    </div>
  );
}