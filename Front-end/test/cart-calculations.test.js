import assert from "node:assert/strict";
import test from "node:test";
import {
  calculateRawTotal,
  calculateCartTotals,
} from "../src/features/Explore/useCartCalculations.js";

test("calculateRawTotal returns 0 for empty or null cart", () => {
  assert.equal(calculateRawTotal([]), 0);
  assert.equal(calculateRawTotal(null), 0);
});

test("calculateRawTotal computes total from items and quantities", () => {
  const items = [
    { price: 20000, quantity: 2 },
    { basePrice: 15000, quantity: 1 },
  ];
  assert.equal(calculateRawTotal(items), 55000);
});

test("calculateCartTotals handles empty cart correctly", () => {
  const result = calculateCartTotals([]);
  assert.deepEqual(result, {
    hasCartItems: false,
    rawTotal: 0,
    subtotal: 0,
    discountAmount: 0,
    tax: 0,
    grandTotal: 0,
  });
});

test("calculateCartTotals calculates standard 10% tax when no promotion is applied", () => {
  const items = [{ price: 100000, quantity: 1 }];
  const result = calculateCartTotals(items, null);

  assert.equal(result.hasCartItems, true);
  assert.equal(result.rawTotal, 100000);
  assert.equal(result.subtotal, 100000);
  assert.equal(result.discountAmount, 0);
  assert.equal(result.tax, 10000);
  assert.equal(result.grandTotal, 110000);
});

test("calculateCartTotals uses evaluation metrics when promotion evaluation is provided", () => {
  const items = [{ price: 100000, quantity: 1 }];
  const evaluation = {
    subtotal: 80000,
    discountAmount: 20000,
    tax: 8000,
    grandTotal: 88000,
  };
  const result = calculateCartTotals(items, evaluation);

  assert.equal(result.hasCartItems, true);
  assert.equal(result.rawTotal, 100000);
  assert.equal(result.subtotal, 80000);
  assert.equal(result.discountAmount, 20000);
  assert.equal(result.tax, 8000);
  assert.equal(result.grandTotal, 88000);
});
