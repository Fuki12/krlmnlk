<template>
  <div class="cart-page">
    <Head title="Корзина" />
    <Header />
    <main class="cart-main">
      <div class="cart-inner">
        <h1 class="page-title animate-item">Корзина</h1>

        <template v-if="isEmpty">
          <div class="cart-empty animate-item animate-delay-1">
            <p class="cart-empty-text">В корзине пока ничего нет</p>
            <Link :href="route('menu')" class="btn-primary">Перейти в меню</Link>
          </div>
        </template>

        <template v-else>
          <div class="cart-actions animate-item animate-delay-1">
            <Link :href="route('menu')" class="cart-back-link">← Продолжить покупки</Link>
            <button type="button" class="cart-clear-btn" @click="clearCart">Очистить корзину</button>
          </div>

          <ul class="cart-list animate-item animate-delay-2">
            <li v-for="item in items" :key="item.id" class="cart-item">
              <div class="cart-item-img-wrap">
                <img :src="item.image" :alt="item.name" class="cart-item-img" />
              </div>
              <div class="cart-item-info">
                <h3 class="cart-item-name">{{ item.name }}</h3>
                <p class="cart-item-price">{{ item.price }} ₽</p>
              </div>
              <div class="cart-item-qty">
                <button type="button" class="qty-btn" @click="updateQuantity(item.id, item.quantity - 1)" aria-label="Уменьшить">−</button>
                <span class="qty-value">{{ item.quantity }}</span>
                <button type="button" class="qty-btn" @click="updateQuantity(item.id, item.quantity + 1)" aria-label="Увеличить">+</button>
              </div>
              <p class="cart-item-sum">{{ item.price * item.quantity }} ₽</p>
              <button type="button" class="cart-item-remove" @click="removeFromCart(item.id)" aria-label="Удалить">×</button>
            </li>
          </ul>

          <div class="cart-footer animate-item animate-delay-3">
            <p class="cart-total">
              <span class="cart-total-label">Итого:</span>
              <span class="cart-total-value">{{ total }} ₽</span>
            </p>
            <button type="button" class="btn-order-submit" @click="onOrderClick">
              Оформить заказ
            </button>
          </div>
        </template>
      </div>
    </main>
    <Footer />
  </div>
</template>

<script>
import { Head, Link } from '@inertiajs/vue3';
import Header from '@/Components/Header.vue';
import Footer from '@/Components/Footer.vue';
import {
  cartItems,
  cartTotal,
  removeFromCart,
  updateQuantity,
  clearCart,
} from '@/stores/cart.js';

export default {
  name: 'CartPage',
  components: { Head, Link, Header, Footer },
  computed: {
    items() {
      return cartItems.value;
    },
    total() {
      return cartTotal.value;
    },
    isEmpty() {
      return cartItems.value.length === 0;
    },
  },
  methods: {
    removeFromCart,
    updateQuantity,
    clearCart,
    onOrderClick() {
      // Пока просто сообщение; позже — страница оформления заказа
      alert('Оформление заказа будет доступно в следующей версии. Позвоните нам: +7 (924) 301-62-54');
    },
  },
}
</script>

<style scoped>
.cart-page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: var(--color-bg);
  color: var(--color-text);
}

.cart-main {
  flex: 1;
  padding: 2rem 5% 3rem;
}

.cart-inner {
  max-width: 800px;
  margin: 0 auto;
}

.page-title {
  font-family: var(--font-heading);
  font-size: clamp(2rem, 4vw, 2.5rem);
  font-weight: 700;
  text-align: center;
  margin: 0 0 2rem;
}

.cart-empty {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 3rem 2rem;
  text-align: center;
}

.cart-empty-text {
  font-size: 1.15rem;
  color: var(--color-text-muted);
  margin: 0 0 1.5rem;
}

.btn-primary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 1rem 2rem;
  background: var(--color-primary);
  color: #fff;
  font-size: 1.05rem;
  font-weight: 700;
  font-family: var(--font-body);
  border-radius: var(--radius);
  text-decoration: none;
  transition: background 0.2s, transform 0.2s;
}

.btn-primary:hover {
  background: var(--color-primary-hover);
  transform: translateY(-2px);
  color: #fff;
}

.cart-actions {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.cart-back-link {
  color: var(--color-accent);
  text-decoration: none;
  font-weight: 600;
  font-size: 0.95rem;
}

.cart-back-link:hover {
  color: var(--color-primary);
}

.cart-clear-btn {
  background: none;
  border: 1px solid var(--color-border);
  color: var(--color-text-muted);
  padding: 0.5rem 1rem;
  border-radius: var(--radius);
  font-size: 0.9rem;
  cursor: pointer;
  transition: color 0.2s, border-color 0.2s;
}

.cart-clear-btn:hover {
  color: var(--color-primary);
  border-color: var(--color-primary);
}

.cart-list {
  list-style: none;
  margin: 0 0 2rem;
  padding: 0;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.cart-item {
  display: grid;
  grid-template-columns: 80px 1fr auto auto auto;
  align-items: center;
  gap: 1rem;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 1rem;
}

.cart-item-img-wrap {
  width: 80px;
  height: 80px;
  border-radius: var(--radius);
  background: var(--color-surface-elevated);
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.cart-item-img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.cart-item-info {
  min-width: 0;
}

.cart-item-name {
  font-family: var(--font-heading);
  font-size: 1.1rem;
  font-weight: 700;
  margin: 0 0 0.25rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.cart-item-price {
  font-size: 0.9rem;
  color: var(--color-text-muted);
  margin: 0;
}

.cart-item-qty {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.qty-btn {
  width: 36px;
  height: 36px;
  border: 1px solid var(--color-border);
  background: var(--color-surface-elevated);
  color: var(--color-text);
  border-radius: var(--radius);
  font-size: 1.25rem;
  line-height: 1;
  cursor: pointer;
  transition: background 0.2s, border-color 0.2s;
}

.qty-btn:hover {
  background: var(--color-surface-hover);
  border-color: var(--color-primary);
}

.qty-value {
  min-width: 2rem;
  text-align: center;
  font-weight: 700;
}

.cart-item-sum {
  font-size: 1.15rem;
  font-weight: 800;
  color: var(--color-accent);
  margin: 0;
  white-space: nowrap;
}

.cart-item-remove {
  width: 36px;
  height: 36px;
  border: none;
  background: transparent;
  color: var(--color-text-muted);
  font-size: 1.5rem;
  line-height: 1;
  cursor: pointer;
  border-radius: var(--radius);
  transition: color 0.2s, background 0.2s;
}

.cart-item-remove:hover {
  color: var(--color-primary);
  background: var(--color-surface-hover);
}

.cart-footer {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: 1.5rem 2rem;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
}

.cart-total {
  margin: 0;
  font-size: 1.25rem;
}

.cart-total-label {
  color: var(--color-text-muted);
  margin-right: 0.5rem;
}

.cart-total-value {
  font-weight: 800;
  font-size: 1.5rem;
  color: var(--color-accent);
}

.btn-order-submit {
  padding: 1rem 2rem;
  background: var(--color-primary);
  color: #fff;
  font-size: 1.05rem;
  font-weight: 700;
  font-family: var(--font-body);
  border: none;
  border-radius: var(--radius);
  cursor: pointer;
  transition: background 0.2s, transform 0.2s;
}

.btn-order-submit:hover {
  background: var(--color-primary-hover);
  transform: translateY(-2px);
}

@media (max-width: 768px) {
  .cart-item {
    grid-template-columns: 60px 1fr;
    grid-template-rows: auto auto auto;
    gap: 0.75rem;
  }

  .cart-item-img-wrap {
    width: 60px;
    height: 60px;
    grid-row: 1 / -1;
  }

  .cart-item-info {
    grid-column: 2;
  }

  .cart-item-qty {
    grid-column: 2;
  }

  .cart-item-sum {
    grid-column: 2;
  }

  .cart-item-remove {
    grid-column: 2;
    justify-self: start;
  }
}

@media (max-width: 480px) {
  .cart-main {
    padding: 1.5rem 3% 2rem;
  }

  .cart-actions {
    flex-direction: column;
    align-items: stretch;
  }

  .cart-footer {
    flex-direction: column;
    align-items: stretch;
    text-align: center;
  }

  .btn-order-submit {
    width: 100%;
  }
}
</style>
