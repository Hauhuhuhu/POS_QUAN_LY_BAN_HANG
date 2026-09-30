import { useEffect, useRef } from "react";

/**
 * Custom hook to listen for Escape key presses and invoke a callback.
 * Uses a ref to ensure the event listener isn't re-attached on every render
 * when the handler reference changes.
 *
 * @param {Function} handler - Callback to invoke on Escape key press
 * @param {boolean} isEnabled - Whether the key listener is currently active
 */
export function useEscapeKey(handler, isEnabled = true) {
  const handlerRef = useRef(handler);

  useEffect(() => {
    handlerRef.current = handler;
  });

  useEffect(() => {
    if (!isEnabled) return;

    const handleKeyDown = (e) => {
      if (e.key === "Escape") {
        handlerRef.current?.(e);
      }
    };

    window.addEventListener("keydown", handleKeyDown);
    return () => window.removeEventListener("keydown", handleKeyDown);
  }, [isEnabled]);
}

export default useEscapeKey;
