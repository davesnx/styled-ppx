import { useLocalStorage } from "./use-local-storage";

export function useLanguage() {
  const [language, setLanguage] = useLocalStorage("language", "reason", {
    initializeWithValue: false,
  });

  return { language, setLanguage };
}
