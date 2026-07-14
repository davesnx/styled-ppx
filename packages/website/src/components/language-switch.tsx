import { useMounted } from "nextra/hooks";
import type { ReactElement } from "react";
import { useLanguage } from "../contexts/use-language";
import { useConfig } from "../contexts/config";
import { Select } from "./select";

const OCamlIcon = (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width="1em"
    height="1em"
    viewBox="0 0 256 256"
  >
    <path fill="#EC6813" d="M0 0h256v256H0z"></path>
    <text
      x="128"
      y="178"
      textAnchor="middle"
      fill="#fff"
      fontFamily="system-ui, sans-serif"
      fontSize="140"
      fontWeight="bold"
    >
      ML
    </text>
  </svg>
);

const ReasonIcon = (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width="1em"
    height="1em"
    viewBox="0 0 256 256"
  >
    <path fill="#dd4b39" d="M0 0h256v256H0z"></path>
    <path
      fill="#fff"
      d="M151.33 232.674h-28.85l-14.215-27.038H89.311v27.038H63.807v-97.697h43.9c25.923 0 40.696 12.543 40.696 34.284c0 14.773-6.132 25.644-17.42 31.497zm-62.019-77.35v29.964h18.536c10.313 0 16.306-5.295 16.306-15.19c0-9.617-5.993-14.774-16.306-14.774zm75.398-20.347h77.07v20.347h-51.565v18.258h46.548v20.208l-46.548.14v18.396h52.96v20.348h-78.465z"
    ></path>
  </svg>
);

type ThemeSwitchProps = {
  lite?: boolean;
  className?: string;
};

type ThemeOptions = {
  reason: string;
  ocaml: string;
};

export function LanguageSwitch({
  lite,
}: ThemeSwitchProps): ReactElement {
  const { frontMatter } = useConfig()
  const { setLanguage, language } = useLanguage();
  const mounted = useMounted();

  const options: ThemeOptions = {
    reason: "Reason",
    ocaml: "OCaml (mlx)",
  };

  const IconToUse = mounted && language == "ocaml" ? OCamlIcon : ReasonIcon;

  if (frontMatter.showAllLanguage) {
    return null
  }

  return (
    <Select
      title="Change language"
      options={[
        { key: "reason", name: options.reason, icon: ReasonIcon },
        { key: "ocaml", name: options.ocaml, icon: OCamlIcon },
      ]}
      onChange={(option) => {
        setLanguage(option.key);
      }}
      selected={{
        key: language,
        icon: IconToUse,
        name: (
          <div className="_flex _items-center _gap-2">
            {IconToUse}
            <span className={lite ? "md:_hidden" : ""}>
              {mounted
                ? options[language as keyof typeof options]
                : options.reason}
            </span>
          </div>
        ),
      }}
    />
  );
}
