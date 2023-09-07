"use client";
import { FormEvent } from "react";

export function NewRoutePage() {
  async function searchPlaces(event: FormEvent) {
    event.preventDefault();
    const source = (document.getElementById("source") as HTMLInputElement)
      .value;
    const destination = (
      document.getElementById("destination") as HTMLInputElement
    ).value;
    const [sourceRes, destinationRes] = await Promise.all([
      fetch(`http://localhost:3000/places?text=${source}`),
      fetch(`http://localhost:3000/places?text=${destination}`),
    ]);
    const [sourcePlace, destinationPlace] = await Promise.all([
      sourceRes.json(),
      destinationRes.json(),
    ]);
  }
  return (
    <div>
      <h1>New Route</h1>
      <form action="" onSubmit={searchPlaces}>
        <div>
          <input type="text" id="source" placeholder="source" />
        </div>
        <div>
          <input type="text" id="destination" placeholder="destination" />
        </div>
        <button type="submit">Search</button>
      </form>
    </div>
  );
}

export default NewRoutePage;
