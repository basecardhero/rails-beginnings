import * as React from 'react'
import { createRoot } from 'react-dom/client';

export const renderComponent = (domId, component) => {
  document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById(domId);
    const root = createRoot(container);
    root.render(component);
  });
};

export const csrfToken = () => {
  return document.querySelector("meta[name='csrf-token']").getAttribute("content");
};
