import { useLanguage } from "../contexts/use-language";

export function LanguageContent({ language, children }) {
  const { language: storedLanguage } = useLanguage();
  return language === storedLanguage ? children : null;
}

export function Re({ children }) {
  return <LanguageContent language="reason">{children}</LanguageContent>;
}

export function Res({ children }) {
  return <LanguageContent language="rescript">{children}</LanguageContent>;
}
