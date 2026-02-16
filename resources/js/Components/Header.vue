<template>
  <header class="header">
    <div class="header-inner">
      <Link :href="route('home')" class="logo-link">
        <div class="logo">
          <img src="/assets/icons/Logo.svg" alt="Логотип" />
        </div>
      </Link>
      <nav class="nav">
        <Link :href="route('menu')" class="nav-link">Меню</Link>
        <Link :href="route('contacts')" class="nav-link">Контакты</Link>
        <Link :href="route('cart')" class="nav-link nav-link-cart">
          Корзина
          <span v-if="cartCount > 0" class="cart-badge">{{ cartCount }}</span>
        </Link>
        <template v-if="$page.props.auth?.user">
          <Link :href="route('cabinet')" class="nav-link nav-link-profile">Профиль</Link>
        </template>
        <template v-else>
          <Link :href="route('login')" class="nav-link">Вход</Link>
          <Link :href="route('register')" class="nav-link nav-link-accent">Регистрация</Link>
        </template>
      </nav>
    </div>
  </header>
</template>

<script>
import { Link } from '@inertiajs/vue3';
import { cartCount } from '@/stores/cart.js';

export default {
  name: 'Header',
  components: { Link },
  computed: {
    cartCount() {
      return cartCount.value;
    },
  },
}
</script>

<style scoped>
.header {
  background: var(--color-surface);
  border-bottom: 1px solid var(--color-border);
  padding: 1rem 0;
  position: sticky;
  top: 0;
  z-index: 100;
  backdrop-filter: blur(12px);
}

.header-inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 5%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo-link {
  text-decoration: none;
  display: flex;
  align-items: center;
  transition: opacity 0.2s;
}

.logo-link:hover {
  opacity: 0.9;
}

.logo img {
  height: 44px;
  width: auto;
  display: block;
}

.nav {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.nav-link {
  padding: 0.5rem 1.25rem;
  border-radius: var(--radius);
  color: var(--color-text);
  text-decoration: none;
  font-size: 1.05rem;
  font-weight: 600;
  font-family: var(--font-body);
  transition: background 0.2s, color 0.2s;
}

.nav-link:hover {
  background: var(--color-surface-hover);
  color: var(--color-primary);
}

.nav-link-accent {
  background: var(--color-primary);
  color: #fff;
}

.nav-link-accent:hover {
  background: var(--color-primary-hover);
  color: #fff;
}

.nav-link-profile {
  font-weight: 700;
}

.nav-link-cart {
  position: relative;
}

.cart-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 20px;
  height: 20px;
  padding: 0 6px;
  margin-left: 4px;
  background: var(--color-primary);
  color: #fff;
  font-size: 0.75rem;
  font-weight: 700;
  border-radius: 10px;
  vertical-align: middle;
}

@media (max-width: 768px) {
  .header-inner {
    padding: 0 4%;
  }

  .logo img {
    height: 36px;
  }

  .nav {
    gap: 0.25rem;
  }

  .nav-link {
    padding: 0.4rem 0.75rem;
    font-size: 0.95rem;
  }
}

@media (max-width: 480px) {
  .header {
    padding: 0.75rem 0;
  }

  .header-inner {
    padding: 0 3%;
  }

  .logo img {
    height: 32px;
  }

  .nav-link {
    padding: 0.35rem 0.6rem;
    font-size: 0.9rem;
  }
}
</style>
