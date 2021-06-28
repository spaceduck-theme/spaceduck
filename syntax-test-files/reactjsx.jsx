import React, { useState } from "react";
import { ANIMALS } from "@frontendmasters/pet";
import useDropdown from "./useDropdown.js";

//NOTE: class => className
const SearchParams = () => {
  // HOOKS -> useState useCallback, useMemo, etc.
  // Stateful logic with react
  const [location, setLocation] = useState("Seattle, WA"); // Destructuring, always give back 2 things: state & updater fn
  const [breeds, setBreeds] = useState([]);
  // Dropdowns
  const [animal, AnimalDropdown] = useDropdown("Animal", "dog", ANIMALS);
  const [breed, BreedDropdown] = useDropdown("Breed", "", breeds);

  return (
    <div className="search-params">
      <form>
        {/* Location */}
        <label htmlFor="location">
          Location
          <input
            id="location"
            value={location}
            placeholder="Location"
            onChange={(event) => setLocation(event.target.value)}
          />
        </label>
        <AnimalDropdown />
        <BreedDropdown />
        <button>Submit</button>
      </form>
    </div>
  );
};

export default SearchParams;
