/**
 * Calculates raw total from cart items.
 *
 * @param {Array} cartItems
 * @returns {number}
 */
export function calculateRawTotal(cartItems = []) {
  if (!cartItems || !cartItems.length) return 0;
  return cartItems.reduce(
    (total, item) =>
      total + (item.price || item.basePrice || 0) * (item.quantity || 1),
    0,
  );
}

/**
 * Computes subtotal, discountAmount, tax, and grandTotal given cartItems and optional promotion evaluation.
 *
 * @param {Array} cartItems
 * @param {Object|null} evaluation - Output from promotion evaluation
 * @returns {{ rawTotal: number, subtotal: number, discountAmount: number, tax: number, grandTotal: number, hasCartItems: boolean }}
 */
export function calculateCartTotals(cartItems = [], evaluation = null) {
  const hasCartItems = Boolean(cartItems && cartItems.length > 0);
  const rawTotal = calculateRawTotal(cartItems);

  if (!hasCartItems) {
    return {
      hasCartItems: false,
      rawTotal: 0,
      subtotal: 0,
      discountAmount: 0,
      tax: 0,
      grandTotal: 0,
    };
  }

  const subtotal = evaluation ? evaluation.subtotal : rawTotal;
  const discountAmount = evaluation ? evaluation.discountAmount : 0;
  const tax = evaluation ? evaluation.tax : rawTotal * 0.1;
  const grandTotal = evaluation ? evaluation.grandTotal : rawTotal + tax;

  return {
    hasCartItems: true,
    rawTotal,
    subtotal,
    discountAmount,
    tax,
    grandTotal,
  };
}

/**
 * Custom hook wrapping calculateCartTotals for use inside React components.
 *
 * @param {Array} cartItems
 * @param {Object|null} evaluation
 * @returns {{ rawTotal: number, subtotal: number, discountAmount: number, tax: number, grandTotal: number, hasCartItems: boolean }}
 */
export function useCartCalculations(cartItems, evaluation) {
  return calculateCartTotals(cartItems, evaluation);
}

export default useCartCalculations;
