import React, { FunctionComponent, InputHTMLAttributes } from 'react';

export interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  textColor: string;
}

export const Input: FunctionComponent<InputProps> = ({
  textColor,
  ...props
}) => <input {...props} style={{ color: textColor }} />;
