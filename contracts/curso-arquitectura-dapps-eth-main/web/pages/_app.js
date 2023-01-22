import "../styles/globals.css";
import Link from "next/link";
import React, {useEffect, useState} from "react"; //Usage of react state
import { ethers } from "ethers"; //Library to connect with any wallet thats in the browser
import styles from "../styles/Home.module.css"; //Functionallity to use CSS styles 

function MyApp({ Component, pageProps }) {

  const [walletAccount, setWalletAccount] = useState("");
  //Variables to follow the connection state
  const [isConnectedToGoerli, setIsConnectedToGoerli] = useState(true); 
  

  //Function to validate if the browser has metamask
  const checkIfMetamaskIsConnected = async ()=> {
    const {ethereum} = window;
    
    if(!ethereum) {
      console.log("Check if metamask is installed");
    } else {
      console.log("Metamask is conected succesfully");

      //Because the function is on it keeps listening during the whole existence of the page
      ethereum.on("chainChanged", function(networkId) {
          if (parseInt(networkId) != 5 ) {
            setIsConnectedToGoerli(false);
          }
          else {
            setIsConnectedToGoerli(true);
          }
      } )
    }
  
  const accounts = await ethereum.request({method: "eth_accounts"});
  
  const provider = new ethers.providers.Web3Provider(ethereum);
  
  //Its not enough to authenticate. That only gets you the account. Its also necesseary to get the signer
  //Who is going to sign the transactions?
  const signer = provider.getSigner();
  
  if(accounts.length != 0) {
    setWalletAccount(accounts[0]);
  } else {
    console.log("There are not authorized accounts");
  }

};

  useEffect(()=> { //Code to make execute a function a single time
    checkIfMetamaskIsConnected();
  }, []);

  //Function to make execute the connection to metamask wallet
  const connectMetamask = async () => {
    try {
        const { ethereum } = window;
        if (!ethereum) {
          alert("Connect your metamask wallet!");
          return;
        }

        const accounts = await ethereum.request({
          method: "eth_requestAccounts",
        });
        console.log(accounts[0]);
        //SetWalletAccount will be useful to get the difference between showing or not the connect wallet buttom
        setWalletAccount(accounts[0]); //Connect the first account in the wallet
        //setIsConnectedToGoerli(ethereum.networkVersion == 5);
    }
    catch (error) {
      console.log(error);
    }
  };

  return (
    <div>

      {!isConnectedToGoerli && (
        <div className = {styles.container}>
          <div className={styles.wrongNetwork}>
            <h1>Wrong Network Connected</h1>
            <p>
              {" "}
              Please connect to the Goerli Network in your metamask. {" "}
              </p>     
          </div>
        </div>
      )}

    {(!walletAccount) && ( //If wallet account doesnt exist. Show this buttom
      <div className={styles.container}>
        <button className = {styles.eth_connect_wallet_button}
        onClick = {connectMetamask}
        >
          Log in
        </button>
      </div>
    )}

    {(walletAccount && isConnectedToGoerli) && ( //If wallet account does actually exist show the menu
  
    <div>
      <main>
        <nav className="border-b p-6">
          <p className="text-4xl font-bold">Platzi Eaters</p>
          <div className="flex mt-4">
            <Link href="/">
              <a className="mr-4 text-pink-500">Inicio</a>
            </Link>
            <Link href="/add-dish">
              <a className="mr-6 text-pink-500">Agregar platillos</a>
            </Link>
            <Link href="/my-dishes">
              <a className="mr-6 text-pink-500">Mis platillos</a>
            </Link>
          </div>
        </nav>
      </main>
      <Component {...pageProps} />
    </div>
  )}
  </div>
  );
}

export default MyApp;
