import React, { ButtonHTMLAttributes, FunctionComponent } from "react";

export interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  text: string;
}

export const Button: FunctionComponent<ButtonProps> = ({
  children,
  text,
  ...props
}) => {
  return (
    <button {...props}>
      {text} - {children}
    </button>
  );
};
