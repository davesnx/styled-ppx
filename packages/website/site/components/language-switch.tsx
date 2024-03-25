import { useMounted } from "nextra/hooks";
import type { ReactElement } from "react";
import { z } from "zod";
import { Select } from "./select";
import { useLanguage } from "../utils/use-language";

function ReScriptIcon() {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="1em"
      height="1em"
      viewBox="0 0 256 256"
    >
      <path
        fill="#d44140"
        d="M247.286 18.765a45.97 45.97 0 0 0-10.099-10.053C225.227 0 208.145 0 173.982 0H81.97C47.81 0 30.729 0 18.765 8.712A44.891 44.891 0 0 0 8.712 18.765C0 30.727 0 47.807 0 82.015v91.967c0 34.161 0 51.233 8.712 63.205a45.97 45.97 0 0 0 10.053 10.1C30.727 256 47.807 256 81.97 256h92.012c34.161 0 51.233 0 63.205-8.714a47.193 47.193 0 0 0 10.1-10.099C256 225.227 256 208.145 256 173.982V82.016c-.01-34.21-.01-51.29-8.714-63.251M118.553 174.123c0 8.007 0 12.055-1.302 15.218a17.217 17.217 0 0 1-9.309 9.309c-3.165 1.302-7.164 1.302-15.22 1.302c-8.006 0-12.055 0-15.218-1.302a17.217 17.217 0 0 1-9.308-9.309c-1.303-3.163-1.303-7.211-1.303-15.218V89.696c0-9.682 0-14.52 1.863-18.196a17.367 17.367 0 0 1 7.54-7.542c3.668-1.86 8.518-1.86 18.152-1.86h24.11zm54.923-50.227c-16.785 0-30.392-13.607-30.392-30.392s13.607-30.392 30.392-30.392c16.786 0 30.393 13.607 30.393 30.392a30.37 30.37 0 0 1-30.351 30.392z"
      ></path>
    </svg>
  );
}

function ReasonIcon() {
  return (
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
}

type ThemeSwitchProps = {
  lite?: boolean;
  className?: string;
};

export const themeOptionsSchema = z.strictObject({
  reason: z.string(),
  rescript: z.string(),
});

type ThemeOptions = z.infer<typeof themeOptionsSchema>;

export function LanguageSwitch({
  lite,
  className,
}: ThemeSwitchProps): ReactElement {
  const { setLanguage, language } = useLanguage();
  const mounted = useMounted();

  const options: ThemeOptions = {
    reason: "Reason",
    rescript: "ReScript",
  };

  const IconToUse = mounted && language == "reason" ? ReasonIcon : ReScriptIcon;

  return (
    <Select
      className={className}
      title="Change language"
      options={[
        { key: "reason", name: options.reason },
        { key: "rescript", name: options.rescript },
      ]}
      onChange={(option) => {
        setLanguage(option.key);
      }}
      selected={{
        key: language,
        name: (
          <div className="nx-flex nx-items-center nx-gap-2 nx-capitalize">
            <IconToUse />
            <span className={lite ? "md:nx-hidden" : ""}>
              {mounted
                ? options[language as keyof typeof options]
                : options.rescript}
            </span>
          </div>
        ),
      }}
    />
  );
}
