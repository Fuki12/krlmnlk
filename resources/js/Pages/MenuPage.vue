<template>
  <div class="menu-page">
    <Head title="Меню" />
    <Header />
    <div class="menu-body">
      <div class="menu-inner">
        <Link :href="route('home')" class="back-link animate-item">← На главную</Link>
        <h1 class="page-title animate-item animate-delay-1">Меню</h1>

        <div class="tabs animate-item animate-delay-2">
          <button
            v-for="tab in tabs"
            :key="tab"
            :class="['tab-btn', { active: activeTab === tab }]"
            @click="activeTab = tab"
          >
            {{ tab }}
          </button>
        </div>

        <div class="cards-grid">
          <article
            v-for="(item, index) in filteredItems"
            :key="item.id"
            :class="['product-card', 'animate-item', 'animate-delay-' + Math.min(index + 3, 7)]"
          >
            <div class="product-img-wrap">
              <img :src="item.image" :alt="item.name" class="product-img" />
            </div>
            <div class="product-body">
              <h3 class="product-title">{{ item.name }}</h3>
              <p class="product-price">{{ item.price }} ₽</p>
              <p class="product-desc">{{ item.desc }}</p>
              <div v-if="cartQuantity(item) === 0" class="product-actions">
                <button type="button" class="btn-order" @click.stop="addToCartAndNotify(item)">
                  В корзину
                </button>
              </div>
              <div v-else class="product-qty-wrap">
                <div class="product-qty">
                  <button type="button" class="qty-btn" @click.stop="updateQuantity(item.id, cartQuantity(item) - 1)" aria-label="Уменьшить">−</button>
                  <span class="qty-value">{{ cartQuantity(item) }}</span>
                  <button type="button" class="qty-btn" @click.stop="updateQuantity(item.id, cartQuantity(item) + 1)" aria-label="Увеличить">+</button>
                </div>
              </div>
            </div>
          </article>
        </div>
      </div>
    </div>

    <Transition name="toast">
      <div v-if="toastVisible" class="toast" role="status">
        <span class="toast-icon">✓</span>
        Добавлено в корзину
      </div>
    </Transition>
    <Footer />
  </div>
</template>

<script>
import { Head, Link } from '@inertiajs/vue3';
import Header from '@/Components/Header.vue';
import Footer from '@/Components/Footer.vue';
import { addToCart, cartItems, updateQuantity } from '@/stores/cart.js';

export default {
  name: 'Menu',
  components: { Head, Link, Header, Footer },
  data() {
    return {
      toastVisible: false,
      activeTab: 'Комбо',
      tabs: ['Роллы и соусы', 'Бургеры', 'Комбо', 'Напитки'],
      products: [
        { id: 1, category: 'Комбо', name: 'ШРИМП БОЕВИК', price: 533, desc: 'Сочный говяжий бифштекс с креветками и соусом.', image: '/assets/images/Shrimp.png' },
        { id: 2, category: 'Комбо', name: 'ТРОЙНОЙ БИГ М', price: 550, desc: 'Бифштекс из 100% говядины с овощами и луковыми кольцами.', image: '/assets/images/BigM.png' },
        { id: 3, category: 'Комбо', name: 'ЧЕРНАЯ ПЯТНИЦА', price: 630, desc: 'Хрустящий картофель, напиток и фирменный соус в комплекте.', image: '/assets/images/Black.png' },
        { id: 4, category: 'Комбо', name: 'ГАМБУРГЕР КОМБО', price: 149, desc: 'Котлета из 100% говядины, маринованные огурцы, напиток.', image: '/assets/images/GumburgerK.png' },
        { id: 5, category: 'Комбо', name: 'БЕКОНАЙЗЕР КОМБО', price: 179, desc: 'Бургер с беконом и сыром, напиток и картофель.', image: '/assets/images/Bekon.png' },
        { id: 6, category: 'Комбо', name: 'ЧИЗБУРГЕР КОМБО', price: 179, desc: 'Чизбургер: 100% говядина, сыр, напиток и картофель.', image: '/assets/images/CheeseK.png' },
        { id: 7, category: 'Роллы и соусы', name: 'МОЦАРЕЛА', price: 279, desc: 'Расплавленная моцарела с хрустящей корочкой и овощами.', image: '/assets/images/Mozzarela.png' },
        { id: 8, category: 'Роллы и соусы', name: 'Чикен', price: 199, desc: 'Курочка с помидорами черри в хрустящем лаваше.', image: '/assets/images/Chiken.png' },
        { id: 9, category: 'Роллы и соусы', name: 'Шаурол', price: 179, desc: 'Ролл с курицей гриль, свежими огурцами и кетчупом.', image: '/assets/images/Shaverma.png' },
        { id: 10, category: 'Роллы и соусы', name: 'Воппер', price: 229, desc: 'Бифштекс с помидорами и соусом в лаваше.', image: '/assets/images/Vopper.png' },
        { id: 11, category: 'Роллы и соусы', name: 'Кетчуп', price: 44, desc: 'Домашний томатный кетчуп.', image: '/assets/images/Ketchup.png' },
        { id: 12, category: 'Роллы и соусы', name: 'Сырный соус', price: 44, desc: 'Кремовый сырный соус.', image: '/assets/images/Chesse.png' },
        { id: 13, category: 'Напитки', name: 'Клубничный шейк', price: 129, desc: 'Освежающий шейк с клубникой, сливками и молоком.', image: '/assets/images/Strawberry.png' },
        { id: 14, category: 'Напитки', name: 'Шоколадный шейк', price: 129, desc: 'Шейк с шоколадом, сливками и шоколадной стружкой.', image: '/assets/images/Choco.png' },
        { id: 15, category: 'Напитки', name: 'Lipton', price: 149, desc: 'Зеленый чай Lipton, освежающий и бодрящий.', image: '/assets/images/Lipton.png' },
        { id: 16, category: 'Напитки', name: 'Coca-Cola', price: 99, desc: 'Классическая Coca-Cola.', image: '/assets/images/CocaCola.png' },
        { id: 17, category: 'Напитки', name: 'Sprite', price: 99, desc: 'Освежающий лимонад.', image: '/assets/images/Sprite.png' },
        { id: 18, category: 'Напитки', name: 'Квас', price: 69, desc: 'Традиционный русский квас с кислинкой.', image: '/assets/images/Kvas.png' },
        { id: 19, category: 'Бургеры', name: 'Цезарь', price: 270, desc: 'Бургер с курицей, салатом и соусом.', image: '/assets/images/Cesar.png' },
        { id: 20, category: 'Бургеры', name: 'Чизбургер', price: 59, desc: 'Классический чизбургер с сыром.', image: '/assets/images/CheeseBurg.png' },
        { id: 21, category: 'Бургеры', name: 'Ангус', price: 129, desc: 'Бургер с говядиной Ангус.', image: '/assets/images/Angus.png' },
        { id: 22, category: 'Бургеры', name: 'Родео', price: 120, desc: 'Бургер с луковыми кольцами и соусом барбекю.', image: '/assets/images/Radeo.png' },
        { id: 23, category: 'Бургеры', name: 'Баварский', price: 150, desc: 'Бургер с сосиской и сыром.', image: '/assets/images/Bavarski.png' },
        { id: 24, category: 'Бургеры', name: 'Фиш', price: 199, desc: 'Рыбный бургер с соусом и свежими овощами.', image: '/assets/images/Fish.png' },
      ],
    }
  },
  computed: {
    filteredItems() {
      return this.products.filter((item) => item.category === this.activeTab)
    },
  },
  methods: {
    cartQuantity(item) {
      const c = cartItems.value.find((i) => i.id === item.id)
      return c ? c.quantity : 0
    },
    addToCartAndNotify(item) {
      addToCart(item)
      this.toastVisible = true
      clearTimeout(this._toastTimer)
      this._toastTimer = setTimeout(() => {
        this.toastVisible = false
      }, 2200)
    },
    updateQuantity(id, qty) {
      updateQuantity(id, qty)
    },
  },
}
</script>

<style scoped>
.menu-page {
  min-height: 100vh;
  background: var(--color-bg);
  color: var(--color-text);
}

.menu-body {
  padding: 2rem 5% 3rem;
}

.menu-inner {
  max-width: 1280px;
  margin: 0 auto;
}

.back-link {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  color: var(--color-accent);
  text-decoration: none;
  font-size: 1rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
  transition: color 0.2s;
}

.back-link:hover {
  color: var(--color-primary);
  text-decoration: none;
}

.page-title {
  font-family: var(--font-heading);
  font-size: clamp(2rem, 4vw, 2.75rem);
  font-weight: 700;
  text-align: center;
  margin: 0 0 2rem;
  color: var(--color-text);
}

.tabs {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 0.75rem;
  margin-bottom: 2.5rem;
}

.tab-btn {
  padding: 0.75rem 1.5rem;
  font-size: 1rem;
  font-weight: 700;
  font-family: var(--font-body);
  color: var(--color-text-muted);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  cursor: pointer;
  transition: background 0.2s, color 0.2s, border-color 0.2s, transform 0.2s;
}

.tab-btn:hover {
  background: var(--color-surface-hover);
  color: var(--color-text);
}

.tab-btn.active {
  background: var(--color-primary);
  color: #fff;
  border-color: var(--color-primary);
  transform: translateY(-1px);
  box-shadow: 0 4px 16px var(--color-primary-glow);
}

.cards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 1.5rem;
}

.product-card {
  background: var(--color-surface);
  border-radius: var(--radius-lg);
  overflow: hidden;
  border: 1px solid var(--color-border);
  display: flex;
  flex-direction: column;
  transition: transform 0.25s, box-shadow 0.25s;
}

.product-card:hover {
  transform: translateY(-6px);
  box-shadow: var(--shadow-hover);
}

.product-img-wrap {
  aspect-ratio: 1;
  background: var(--color-surface-elevated);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1rem;
}

.product-img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.product-body {
  padding: 1.25rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  flex: 1;
}

.product-title {
  font-family: var(--font-heading);
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
  line-height: 1.2;
}

.product-price {
  font-size: 1.35rem;
  font-weight: 800;
  color: var(--color-accent);
  margin: 0;
}

.product-desc {
  font-size: 0.9rem;
  color: var(--color-text-muted);
  margin: 0;
  flex: 1;
  line-height: 1.4;
}

.btn-order {
  width: 100%;
  min-height: 48px;
  padding: 0 1rem;
  margin-top: 0.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  box-sizing: border-box;
  background: var(--color-primary);
  color: #fff;
  font-size: 1rem;
  font-weight: 700;
  font-family: var(--font-body);
  border: none;
  border-radius: var(--radius);
  cursor: pointer;
  transition: background 0.2s, transform 0.2s;
}

.btn-order:hover {
  background: var(--color-primary-hover);
  transform: translateY(-1px);
}

.product-actions {
  margin-top: 0.5rem;
}

.product-qty-wrap {
  margin-top: 0.5rem;
  width: 100%;
}

.product-qty {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  min-height: 48px;
  padding: 0 1rem;
  box-sizing: border-box;
  background: var(--color-surface-elevated);
  border: 1px solid var(--color-border);
  border-radius: var(--radius);
  transition: border-color 0.2s, background 0.2s;
}

.product-qty:hover {
  background: var(--color-surface-hover);
}

.product-qty .qty-btn {
  width: 32px;
  height: 32px;
  flex-shrink: 0;
  border: none;
  background: var(--color-surface-hover);
  color: var(--color-text);
  border-radius: 8px;
  font-size: 1.2rem;
  line-height: 1;
  cursor: pointer;
  transition: background 0.2s, color 0.2s;
}

.product-qty .qty-btn:hover {
  background: var(--color-primary);
  color: #fff;
}

.product-qty .qty-value {
  min-width: 2rem;
  text-align: center;
  font-weight: 700;
  font-size: 1rem;
  color: var(--color-text);
}

/* Тостер «Добавлено в корзину» */
.toast {
  position: fixed;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.9rem 1.5rem;
  background: var(--color-surface);
  border: 1px solid var(--color-primary);
  border-radius: var(--radius);
  color: var(--color-text);
  font-weight: 600;
  font-size: 0.95rem;
  box-shadow: var(--shadow-hover);
  z-index: 1000;
}

.toast-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  background: var(--color-primary);
  color: #fff;
  border-radius: 50%;
  font-size: 0.9rem;
  line-height: 1;
}

.toast-enter-active,
.toast-leave-active {
  transition: opacity 0.3s ease, transform 0.3s ease;
}

.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: translateX(-50%) translateY(1rem);
}

@media (max-width: 768px) {
  .menu-body {
    padding: 1.5rem 4% 2rem;
  }

  .back-link {
    font-size: 0.95rem;
    margin-bottom: 1.25rem;
  }

  .page-title {
    font-size: 1.75rem;
    margin-bottom: 1.5rem;
  }

  .tabs {
    gap: 0.5rem;
    margin-bottom: 2rem;
  }

  .tab-btn {
    padding: 0.6rem 1rem;
    font-size: 0.9rem;
  }

  .cards-grid {
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 1.25rem;
  }

  .product-body {
    padding: 1rem;
  }

  .product-title {
    font-size: 1.15rem;
  }

  .product-price {
    font-size: 1.2rem;
  }

  .product-desc {
    font-size: 0.85rem;
  }

  .btn-order {
    padding: 0.75rem;
    font-size: 0.95rem;
  }
}

@media (max-width: 480px) {
  .menu-body {
    padding: 1rem 3% 1.5rem;
  }

  .back-link {
    font-size: 0.9rem;
    margin-bottom: 1rem;
  }

  .page-title {
    font-size: 1.5rem;
    margin-bottom: 1.25rem;
  }

  .tabs {
    flex-direction: column;
    margin-bottom: 1.5rem;
  }

  .tab-btn {
    width: 100%;
    padding: 0.7rem 1rem;
    font-size: 0.9rem;
  }

  .cards-grid {
    grid-template-columns: 1fr;
    gap: 1rem;
  }

  .product-img-wrap {
    padding: 0.75rem;
  }

  .product-body {
    padding: 0.9rem;
  }

  .product-title {
    font-size: 1.1rem;
  }

  .product-price {
    font-size: 1.15rem;
  }

  .product-desc {
    font-size: 0.8rem;
  }
}
</style>
