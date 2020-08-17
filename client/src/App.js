import React from "react";
import Peronialand from "./artifacts/Peronialand.json";
import { DrizzleProvider } from "drizzle-react";
import {
  AccountData,
  ContractData,
  ContractForm,
  LoadingContainer,
} from "drizzle-react-components";

const drizzleOptions = {
  contracts: [Peronialand],
};

const App = () => (
  <DrizzleProvider options={drizzleOptions}>
    <LoadingContainer>
      <div>
        <h2>hello dapp</h2>
        <div>Your account:</div>
        <AccountData accountIndex={0} units="ether" precision={8} />
        <div>Greeting from blockchain:</div>
        <ContractData contract="Peronialand" method="getGreeting" />
        <div>Set greeting value into blockchain:</div>
        <ContractForm contract="Peronialand" method="setGreeting" />
      </div>
    </LoadingContainer>
  </DrizzleProvider>
);

export default App;
