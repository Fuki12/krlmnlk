import { ref, computed } from 'vue';

const STORAGE_KEY = 'crazyburger_cart';

function load() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

function save(items) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(items));
  } catch (_) {}
}

const items = ref(load());

export const cartItems = items;

export function addToCart(product, quantity = 1) {
  const list = items.value;
  const existing = list.find((i) => i.id === product.id);
  if (existing) {
    existing.quantity += quantity;
  } else {
    list.push({
      id: product.id,
      name: product.name,
      price: product.price,
      image: product.image,
      quantity,
    });
  }
  save(list);
}

export function removeFromCart(id) {
  items.value = items.value.filter((i) => i.id !== id);
  save(items.value);
}

export function updateQuantity(id, quantity) {
  const item = items.value.find((i) => i.id === id);
  if (!item) return;
  if (quantity < 1) {
    removeFromCart(id);
    return;
  }
  item.quantity = quantity;
  save(items.value);
}

export function clearCart() {
  items.value = [];
  save(items.value);
}

export const cartCount = computed(() =>
  items.value.reduce((sum, i) => sum + i.quantity, 0)
);

export const cartTotal = computed(() =>
  items.value.reduce((sum, i) => sum + i.price * i.quantity, 0)
);
