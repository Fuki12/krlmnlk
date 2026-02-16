<template>
  <section class="section burgers">
    <div class="section-inner">
      <h2 class="section-title animate-item">Популярные бургеры</h2>
      <div class="burgers-grid">
        <div class="burger-card animate-item" v-for="(burger, i) in burgers" :key="burger.id" :class="'animate-delay-' + (i + 2)" @click="openBurger(burger)">
          <div class="burger-img">
            <img :src="burger.image" :alt="burger.name" />
          </div>
          <div class="burger-body">
            <h3 class="burger-title">{{ burger.name }}</h3>
            <p class="burger-desc">{{ burger.description }}</p>
            <button class="btn-card" @click.stop="orderBurger(burger)">Заказать</button>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="section promo-section" id="promo">
    <div class="section-inner">
      <h2 class="section-title section-title-light animate-item">Акции</h2>
      <p class="promo-subtitle animate-item animate-delay-1">Успей заказать до пятницы!</p>
      <div class="promo-cards">
        <div class="promo-card animate-item" v-for="(item, i) in promo" :key="item.id" :class="'animate-delay-' + (i + 2)">
          <div class="promo-img-wrap">
            <img :src="item.image" :alt="item.name" class="promo-img" />
          </div>
          <h3 class="promo-name">{{ item.name }}</h3>
          <p class="promo-price">{{ item.price }} ₽</p>
          <div class="promo-comp-title">Состав</div>
          <p class="promo-comp">{{ item.comp }}</p>
          <Link :href="route('menu')" class="btn-card">Выбрать</Link>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { Link, router } from '@inertiajs/vue3';

export default {
  components: { Link },
  data() {
    return {
      burgers: [
        { id: 1, name: 'Чеддер КИНГ', description: 'Двойной сыр, сочная котлета, бекон, майонез', image: '/assets/images/Chedder.png' },
        { id: 2, name: 'Острый Техас', description: 'Пикантный бургер с перцем халапеньо, BBQ соус', image: '/assets/images/Texac.png' },
      ],
      promo: [
        { id: 1, name: 'ГАМБУРГЕР', price: 99, comp: 'Зеленый перец, румяная булочка. Булочка с кунжутом (55 г), котлета из говядины, огурцы маринованные, кетчуп, горчица.', image: '/assets/images/Gumburger.png' },
        { id: 2, name: 'ЗЕЛЕНЫЙ ФРЕШ', price: 52, comp: 'Зеленая булочка, чесночный соус. Котлета из говядины, томаты, лук, салат, перец халапеньо и острый соус.', image: '/assets/images/Green.png' },
        { id: 3, name: 'ПИНК', price: 299, comp: 'Сыр, огурчики, розовая булочка. Растительная котлета, мята, кинза, мусс из копчёной груши и кимчи.', image: '/assets/images/Pink.png' },
      ],
    }
  },
  methods: {
    openBurger() {
      router.visit(route('menu'))
    },
    orderBurger() {
      router.visit(route('menu'))
    },
  },
}
</script>

<style scoped>
.section {
  padding: 4rem 5%;
}

.section-inner {
  max-width: 1280px;
  margin: 0 auto;
}

.section-title {
  font-family: var(--font-heading);
  font-size: clamp(2rem, 4vw, 2.5rem);
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 2.5rem;
  text-align: center;
}

.section-title-light {
  color: var(--color-text);
}

/* ——— Бургеры ——— */
.burgers {
  background: var(--color-bg);
}

.burgers-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 2rem;
  align-items: stretch;
}

.burger-card {
  background: var(--color-surface);
  border-radius: var(--radius-lg);
  overflow: hidden;
  border: 1px solid var(--color-border);
  transition: transform 0.25s, box-shadow 0.25s;
  cursor: pointer;
}

.burger-card:hover {
  transform: translateY(-6px);
  box-shadow: var(--shadow-hover);
}

.burger-img {
  aspect-ratio: 4/3;
  background: var(--color-surface-elevated);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1.5rem;
}

.burger-img img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.burger-body {
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.burger-title {
  font-family: var(--font-heading);
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--color-text);
  margin: 0;
}

.burger-desc {
  font-size: 1rem;
  color: var(--color-text-muted);
  margin: 0;
  flex: 1;
}

/* ——— Акции ——— */
.promo-section {
  background: var(--color-surface);
  border-top: 1px solid var(--color-border);
}

.promo-subtitle {
  text-align: center;
  font-size: 1.15rem;
  color: var(--color-accent);
  font-weight: 700;
  margin: -0.5rem 0 2.5rem;
}

.promo-cards {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.5rem;
}

.promo-card {
  background: var(--color-surface-elevated);
  border-radius: var(--radius-lg);
  padding: 1.5rem;
  border: 1px solid var(--color-border);
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  transition: transform 0.25s, box-shadow 0.25s;
}

.promo-card:hover {
  transform: translateY(-6px);
  box-shadow: var(--shadow-hover);
}

.promo-img-wrap {
  width: 100%;
  aspect-ratio: 1;
  background: var(--color-bg);
  border-radius: var(--radius);
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}

.promo-img {
  width: 85%;
  height: 85%;
  object-fit: contain;
}

.promo-name {
  font-family: var(--font-heading);
  font-size: 1.35rem;
  font-weight: 700;
  color: var(--color-text);
  margin: 0 0 0.25rem;
}

.promo-price {
  font-size: 1.5rem;
  font-weight: 800;
  color: var(--color-accent);
  margin: 0 0 0.75rem;
}

.promo-comp-title {
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  color: var(--color-text-muted);
  margin-bottom: 0.5rem;
}

.promo-comp {
  font-size: 0.9rem;
  color: var(--color-text-muted);
  line-height: 1.45;
  margin: 0 0 1.25rem;
  flex: 1;
  white-space: pre-line;
}

/* Кнопка карточки */
.btn-card {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  padding: 0.85rem 1.5rem;
  background: var(--color-primary);
  color: #fff;
  font-size: 1rem;
  font-weight: 700;
  font-family: var(--font-body);
  border-radius: var(--radius);
  border: none;
  cursor: pointer;
  text-decoration: none;
  transition: background 0.2s, transform 0.2s;
}

.btn-card:hover {
  background: var(--color-primary-hover);
  transform: translateY(-1px);
  color: #fff;
}

@media (max-width: 900px) {
  .burgers-grid {
    grid-template-columns: 1fr;
  }

  .promo-cards {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .section {
    padding: 3rem 4%;
  }

  .section-title {
    font-size: 1.75rem;
    margin-bottom: 2rem;
  }

  .burgers-grid {
    gap: 1.5rem;
  }

  .burger-body {
    padding: 1.25rem;
  }

  .burger-title {
    font-size: 1.35rem;
  }

  .burger-desc {
    font-size: 0.95rem;
  }

  .promo-subtitle {
    font-size: 1rem;
    margin-bottom: 2rem;
  }

  .promo-cards {
    gap: 1.25rem;
  }

  .promo-card {
    padding: 1.25rem;
  }

  .promo-name {
    font-size: 1.2rem;
  }

  .promo-price {
    font-size: 1.35rem;
  }

  .promo-comp {
    font-size: 0.85rem;
  }
}

@media (max-width: 480px) {
  .section {
    padding: 2rem 3%;
  }

  .section-title {
    font-size: 1.5rem;
    margin-bottom: 1.5rem;
  }

  .burgers-grid {
    gap: 1.25rem;
  }

  .burger-img {
    padding: 1rem;
  }

  .burger-body {
    padding: 1rem;
  }

  .burger-title {
    font-size: 1.2rem;
  }

  .burger-desc {
    font-size: 0.9rem;
  }

  .btn-card {
    padding: 0.75rem 1rem;
    font-size: 0.95rem;
  }

  .promo-subtitle {
    font-size: 0.95rem;
    margin-bottom: 1.5rem;
  }

  .promo-card {
    padding: 1rem;
  }

  .promo-name {
    font-size: 1.1rem;
  }

  .promo-price {
    font-size: 1.25rem;
  }

  .promo-comp-title {
    font-size: 0.7rem;
  }

  .promo-comp {
    font-size: 0.8rem;
  }
}
</style>
