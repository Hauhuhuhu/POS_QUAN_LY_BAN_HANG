import { useEffect } from "react";

/**
 * Custom hook to lock body scrolling when a modal or overlay is active.
 * Restores the previous overflow style on cleanup.
 *
 * @param {boolean} isLocked - Whether scrolling should be locked
 */
export function useLockBodyScroll(isLocked = true) {
  useEffect(() => {
    if (!isLocked || typeof document === "undefined") return;

    const originalOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";

    return () => {
      document.body.style.overflow = originalOverflow;
    };
  }, [isLocked]);
}

export default useLockBodyScroll;
