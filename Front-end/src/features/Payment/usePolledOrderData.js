import { useQuery } from "@tanstack/react-query";
import { getOrderById } from "../../services/OrderService";

export function usePolledOrderData(baseData, orderId) {
  const initial = baseData?.data || baseData;
  const isInitiallyCompleted = initial?.paymentDetails?.status === "COMPLETED";

  const { data: polledOrderData } = useQuery({
    queryKey: ["order", orderId],
    queryFn: () => getOrderById(orderId),
    initialData: baseData || undefined,
    enabled: Boolean(orderId) && !isInitiallyCompleted,
    refetchInterval: (query) => {
      const current = query?.state?.data;
      const resolved = current?.data || current;
      return resolved?.paymentDetails?.status === "COMPLETED" ? false : 3000;
    },
  });

  return { polledOrderData };
}
