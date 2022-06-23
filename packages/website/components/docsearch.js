import { useRef, useEffect } from "react";

const Search = () => {
  const input = useRef(null);

  useEffect(() => {
    const inputs = ["input", "select", "button", "textarea"];

    const down = (e) => {
      if (
        document.activeElement &&
        inputs.indexOf(document.activeElement.tagName.toLowerCase() !== -1)
      ) {
        if (e.key === "/") {
          e.preventDefault();
          input.current?.focus();
        }
      }
    };

    window.addEventListener("keydown", down);
    return () => window.removeEventListener("keydown", down);
  }, []);

  useEffect(() => {
    if (window.docsearch) {
      window.docsearch({
        apiKey: "f96e25f97c4b8b5d598a4adf03962cd2",
        indexName: "styled-ppx-documentation-content",
        inputSelector: "input#algolia-doc-search",
      });
    }
  }, []);

  return (
    <div className="relative w-56 docs-search">
      <input
        id="algolia-doc-search"
        className="appearance-none border rounded py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline w-full"
        type="search"
        placeholder='Search (Press "/" to focus)'
        ref={input}
      />
    </div>
  );
};

export default Search;
